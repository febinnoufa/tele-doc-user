import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teledocuser/const/const.dart';
import 'package:teledocuser/views/screens/myappoiment/myappoiment.dart';
import 'package:teledocuser/views/screens/profile_Screen/profile_screen.dart';
import 'package:teledocuser/views/screens/home/home_screen.dart';
import 'package:teledocuser/views/screens/search/serach.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class BotomNavigationBar extends StatefulWidget {
  const BotomNavigationBar({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _BotomNavigationBarState createState() => _BotomNavigationBarState();
}

class _BotomNavigationBarState extends State<BotomNavigationBar> {
  final Color navigationBarColor = Colors.white;
  int selectedIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: <Widget>[
              const HomeScreen(),
              SearchPage(),
              const MyAppointmentScreen(),
              const ProfileScreenUser(),
            ],
          ),
          bottomNavigationBar: WaterDropNavBar(
            backgroundColor: blackColor,
            waterDropColor: greenColor,
            inactiveIconColor: Colors.black,
            onItemSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
              pageController.animateToPage(selectedIndex,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutQuad);
            },
            selectedIndex: selectedIndex,
            barItems: <BarItem>[
              BarItem(
                filledIcon: Icons.home_filled,
                outlinedIcon: Icons.home_outlined,
              ),
              BarItem(
                  filledIcon: Icons.search_outlined,
                  outlinedIcon: Icons.search),
              BarItem(
                filledIcon: Icons.medical_information,
                outlinedIcon: Icons.medical_information_outlined,
              ),
              BarItem(
                filledIcon: Icons.grid_view_rounded,
                outlinedIcon: Icons.grid_view_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
