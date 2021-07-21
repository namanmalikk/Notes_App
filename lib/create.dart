import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CreatePage extends StatefulWidget {
  final Client client;
  const CreatePage({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  var createNoteUrl = Uri.parse('http://10.0.2.2:8000/api/notes/create/');

  void _createNote() {
    widget.client.post(createNoteUrl, body: {
      'title': controller1.text,
      'description': controller2.text,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new Note"),
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
                _createNote();
              },
              child: Text("Create Note"))
        ],
      ),
    );
  }
}
