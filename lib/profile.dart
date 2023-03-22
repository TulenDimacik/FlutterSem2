import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_core/firebase_core.dart';

final FirebaseFirestore fireStore = FirebaseFirestore.instance;
Future<void> add() {
  final user = fireStore.collection('user');
  return user
      .add(
        {
          'name': 'John Doe',
          'age': 30,
          'email': 'johndoe@example.com',
        },
      )
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
