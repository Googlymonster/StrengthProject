import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Api {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  Api({this.path}) {
    ref = _db.collection(path);
  }

  // Create a stream of snapshots for streambuilder
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  // Add a new document to a collection
  Future<DocumentReference> addDocument(Map data) async {
    return ref.add(data);
  }

  // Get all documents from a collection
  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  // Get document by documentId
  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  // Remove specific document
  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  // Update specific document with data
  Future<void> updateDocument(Map data, String id) {
    return ref.document(id).updateData(data);
  }
}
