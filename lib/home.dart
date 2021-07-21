import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'create.dart';
import 'note.dart';
import 'update.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var client = http.Client();
  var getNotesUrl = Uri.parse('http://10.0.2.2:8000/api/notes/');

  List<Note> notes = [];

  void initState() {
    _getNotes();
    super.initState();
  }

  void _getNotes() async {
    notes = [];

    List response = json.decode((await client.get(getNotesUrl)).body);
    response.forEach((element) {
      notes.add(Note.fromMap(element));
    });

    setState(() {});
  }

  void _deleteNote(int noteId) {
    var deleteNoteUrl =
        Uri.parse('http://10.0.2.2:8000/api/notes/${noteId}/delete/');

    client.delete(deleteNoteUrl);
    _getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _getNotes();
        },
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  notes[index].title,
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdatePage(
                      client: client,
                      id: notes[index].id,
                      title: notes[index].title,
                      description: notes[index].description,
                    ),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteNote(notes[index].id),
                ),
                tileColor: Colors.deepPurple[50],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreatePage(client: client),
          ),
        ),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
