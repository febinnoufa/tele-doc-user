import 'package:flutter/material.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final dynamic article;

  const ArticleDetailsScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 1,
      
        title: Text(article['name'] ?? 'Article Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article['urlToImage'] != null)
            Card(
              elevation: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0), 
                  child: FadeInImage.assetNetwork(placeholder: "assets/ArticlesCategory-Health.jpg", image:  article['urlToImage'],fit: BoxFit.cover,height: 200,)
                
                ),
              ),
          const  SizedBox(height: 36),
            Text(
              article['title'] ?? 'No Title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            const SizedBox(height: 28),
            Text(
              article['description'] ?? 'No Description',
              style: const TextStyle(fontSize: 16,color: Colors.white),
            ),
            const SizedBox(height: 18),
            Text(
              article['content'] ?? 'No Content',
              style: const TextStyle(fontSize: 14,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
