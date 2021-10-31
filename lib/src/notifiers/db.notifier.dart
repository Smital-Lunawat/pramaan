import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Database extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// aadharNum private variable
  String? aadharNum;

  /// aadharNum public getter
  String? get aadharNumGetter => aadharNum;

  /// aadharNum public setter
  set aadharNumSetter(String? aadharNum) {
    this.aadharNum = aadharNum;
    notifyListeners();
  }

  /// userData private variable
  Map<String, dynamic>? _userData;

  /// getter for userData
  Map<String, dynamic>? get userData => _userData;

  /// setter for userData
  set userData(Map<String, dynamic>? userData) {
    _userData = userData;
    notifyListeners();
  }

  /// Fetch data from firestore database and return a list of [Data]
  Future<void> getData(String documentId) async {
    /// Collection of `residentDB` in firestore.
    CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection('residentDB');

    /// Document of the collection with a unique `documentId`.
    DocumentSnapshot<Map<String, dynamic>> docData = await collection.doc(documentId).get();

    /// Set the data to the `userData` variable.
    userData = docData.data();

    /// set the aadhar number to the `aadharNum` variable.
    aadharNum = userData!['Aadhaar'];
  }
}
