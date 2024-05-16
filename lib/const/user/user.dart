// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:teledocuser/screens/singup/model/usermodel.dart';


// class UserController extends GetxController {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   Rx<UserModel?> user = Rx<UserModel?>(null); // Initialize with null

//   Future<void> getUser(String userId) async {
//     try {
//       DocumentSnapshot<Map<String, dynamic>> userSnapshot = await _db.collection('users').doc(userId).get();
//       if (userSnapshot.exists) {
//         user.value = UserModel.fromMap(userSnapshot.data()! as DocumentSnapshot<Object?>, userSnapshot.id); // Use data()!
//       } else {
//         user.value = null;
//       }
//     } catch (e) {
//       print('Error fetching user data: $e');
//     }
//   }
// }
