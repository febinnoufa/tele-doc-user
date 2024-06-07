import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String date;
  final String startTime;
  final String endTime;
  final String docId;
  final DateTime createdAt;

  Schedule({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.docId,
    required this.createdAt,
  });

  factory Schedule.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Schedule(
      date: data['date'] ?? '',
      startTime: data['startTime'] ?? '',
      endTime: data['endTime'] ?? '',
      docId: data['docId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}