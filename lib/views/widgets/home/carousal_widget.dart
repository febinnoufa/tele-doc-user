import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:teledocuser/views/widgets/home/article_details.dart';
import 'dart:convert';

 // Import the new screen
import 'package:teledocuser/const/const.dart';

class CarousalHomeWidget extends StatefulWidget {
  const CarousalHomeWidget({super.key});

  @override
  _CarousalHomeWidgetState createState() => _CarousalHomeWidgetState();
}

class _CarousalHomeWidgetState extends State<CarousalHomeWidget> {
  List<dynamic> news = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    const apiKey = '977cf2daea6e4b229621a9ba8fe3b765';
    const url =
        'https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        news = data['articles'];
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        CarouselSlider(
          options: CarouselOptions(
            height: 220,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.9,
          ),
          items: news.map((article) => buildCarouselItem(article)).toList(),
        ),
      ],
    );
  }

  Widget buildCarouselItem(dynamic article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailsScreen(article: article),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: greenColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: article['urlToImage'] != null
                    ? FadeInImage.assetNetwork(
                        placeholder: 'assets/ArticlesCategory-Health.jpg',
                        image: article['urlToImage'],
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/ArticlesCategory-Health.jpg");
                        },
                      )
                    : Image.network(
                        "https://www.pnbmetlife.com/content/dam/pnb-metlife/images/articles/ArticlesCategory-Health.jpg",
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article['title'] ?? 'No Title',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


