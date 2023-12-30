import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/Note.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add or Update a note
  Future<void> saveNote(Note note) {
    if (note.id.isNotEmpty) {
      // Update existing note
      return _db.collection('notes').doc(note.id).update(note.toFirestore());
    } else {
      // Add new note
      return _db.collection('notes').add(note.toFirestore());
    }
  }

  // Delete a note
  Future<void> deleteNote(String noteId) {
    return _db.collection('notes').doc(noteId).delete();
  }

  // Stream of notes
  Stream<List<Note>> getNotes() {
    return _db.collection('notes').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList());
  }
}
