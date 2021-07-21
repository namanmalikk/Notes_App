import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdatePage extends StatefulWidget {
  final Client client;
  final int id;
  final String title;
  final String description;

  const UpdatePage({
    Key? key,
    required this.client,
    required this.id,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  void initState() {
    controller1.text = widget.title;
    controller2.text = widget.description;
    super.initState();
  }

  void _updateNote() {
    var updateNoteUrl =
        Uri.parse('http://10.0.2.2:8000/api/notes/${widget.id}/update/');
    widget.client.put(updateNoteUrl, body: {
      'title': controller1.text,
      'description': controller2.text,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update new Note"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller1,
            maxLines: 2,
          ),
          TextField(
            controller: controller2,
            maxLines: 6,
          ),
          ElevatedButton(
              onPressed: () {
                _updateNote();
              },
              child: Text("Update Note"))
        ],
      ),
    );
  }
}
