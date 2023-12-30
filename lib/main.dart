import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Model/Note.dart';
import 'Service/FirestoreService.dart';
import 'edit_note_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NoteListScreen(),
    );
  }
}

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: StreamBuilder<List<Note>>(
        stream: _firestoreService.getNotes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var notes = snapshot.data;
          return ListView.builder(
            itemCount: notes?.length ?? 0,
            itemBuilder: (context, index) {
              var note = notes![index];
              return Container(
                color: index % 2 == 0 ? Colors.white : Colors.grey[200],
                // Alternating colors
                child: ListTile(
                  title: Text(note.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(note.content, style: const TextStyle(fontSize: 16)),
                      Text(
                        DateFormat('yyyy-MM-dd – kk:mm').format(note.createdAt),
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12),
                      ),
                      // Format the date as needed
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_forever_outlined,
                        color: Colors.red),
                    // Set the color to red
                    onPressed: () => _showDeleteConfirmation(context, note),
                  ),
                  onTap: () {
                    print("Tapped Note: ${note.title}, ${note.content}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditNoteScreen(note: note)),
                    );
                  },
                  // Rest of the code remains the same...
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditNoteScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                // Call method to delete the note and then dismiss the dialog
                _firestoreService.deleteNote(note.id);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
