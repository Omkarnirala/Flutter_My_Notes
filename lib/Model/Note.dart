import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String id;
  String title;
  String content;
  bool isPinned;
  DateTime createdAt;
  DateTime lastEditedAt;

  Note({
    this.id = '',
    required this.title,
    required this.content,
    this.isPinned = false,
    DateTime? createdAt,
    DateTime? lastEditedAt,
  }) : createdAt = createdAt ?? DateTime.now(), lastEditedAt = lastEditedAt ?? DateTime.now(); // Default to current time if not provided

  factory Note.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Note(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      isPinned: data['isPinned'] ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastEditedAt: (data['lastEditedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'isPinned': isPinned,
      'createdAt': createdAt,
      'lastEditedAt': lastEditedAt,
    };
  }
}
