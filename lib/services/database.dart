import 'package:cloud_firestore/cloud_firestore.dart';

// https://www.youtube.com/watch?v=mtNA1neFNVo
class DatabaseService {

  // collection reference

  final CollectionReference exerciseCollection = FirebaseFirestore.instance.collection('exercises');



}