import 'package:flutter/material.dart';

import 'Model/Note.dart';
import 'Service/FirestoreService.dart';

class EditNoteScreen extends StatefulWidget {
  final Note? note;

  const EditNoteScreen({super.key, this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  late bool _isPinned;

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _isPinned = widget.note!.isPinned; // Set the pin state based on the note
    } else {
      _isPinned = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
        actions: <Widget>[
          // Pin Icon Button - Reflects the current pin state
          // IconButton(
          //   icon: Icon(_isPinned ? Icons.push_pin : Icons.push_pin_outlined),
          //   onPressed: () {
          //     setState(() {
          //       _isPinned = !_isPinned; // Toggle the pin state
          //     });
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNote,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Aligns children to the start of the cross axis
          children: <Widget>[
            TextField(
              maxLength: 50,  // Set the maximum number of characters
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Note',
                  alignLabelWithHint: true,
                  // Aligns the label to the top when the field is empty
                  contentPadding: EdgeInsets.only(top: 12.0), // Adjust padding as needed
                ),
                maxLines: null,
                expands: true,
                textAlign: TextAlign.start,
                textAlignVertical:
                    TextAlignVertical.top, // Aligns text vertically to the top
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveNote() async {
    Note noteToSave;
    String content = _contentController.text.trim();

    // Check if title or content is empty
    if (content.isEmpty) {
      // Show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot create an empty note'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
      return; // Exit the method if validation fails
    }

    if (widget.note == null) {
      // Create a new note
      noteToSave = Note(
        title: _titleController.text,
        content: _contentController.text,
        lastEditedAt: DateTime.now(),
      );
    } else {
      // Update the existing note
      noteToSave = Note(
        id: widget.note!.id,
        title: _titleController.text,
        content: _contentController.text,
        isPinned: widget.note!.isPinned,
        createdAt: widget.note!.createdAt,
        lastEditedAt: DateTime.now(), // Preserve the original creation date
      );
    }

    Navigator.pop(context);
    await _firestoreService.saveNote(noteToSave);
  }
}
