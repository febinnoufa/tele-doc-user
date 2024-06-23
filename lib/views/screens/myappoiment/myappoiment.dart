import 'package:flutter/material.dart';
import 'package:teledocuser/views/screens/myappoiment/past.dart';
import 'package:teledocuser/views/screens/myappoiment/upcoming.dart';
import 'package:teledocuser/views/widgets/appbar/appbar.dart';

class MyAppointmentScreen extends StatelessWidget {
  const MyAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
           AppBarWidget(title: "My Appointment"),
            SizedBox(height: 20),
            TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: "Upcoming"),
                Tab(text: "Past"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  UpcomingAppointments(),
                  PastAppointments()
                  // Center(
                  //   child: Text(
                  //     "Past Appointments",
                  //     style: TextStyle(color: Colors.black),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
