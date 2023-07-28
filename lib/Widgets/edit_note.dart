import 'package:flutter/material.dart';
import 'package:flutter_notes/Database/Database_helper.dart';
import 'package:flutter_notes/Widgets/main_menu.dart';

class edit_note extends StatelessWidget {
  final int? index;
  final String? title;
  final String? text;

  const edit_note({Key? key, required this.index, this.title, this.text})
      : super(key: key);

  Future<void> addNote(String title, String? text) async {
    await DatabaseHelper.createNote(title, text);
  }

  @override
  Widget build(BuildContext context) {
    final tittleTextFieldController = TextEditingController();
    final textFieldController = TextEditingController();

    if (index != null) {
      tittleTextFieldController.text = title!;
      textFieldController.text = text!;
    }

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              if (index != null) {
                try {
                  // TODO Починить обновление данных
                  DatabaseHelper.updateNote(index!,
                      tittleTextFieldController.text, textFieldController.text);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Successfully update!',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.black54));
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => main_menu()),
                  );
                } on Exception catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Update fail!',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.black54));
                }
              } else {
                try {
                  addNote(
                      tittleTextFieldController.text, textFieldController.text);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Successfully create!',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.black54));

                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => main_menu()),
                  );
                } on Exception catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Create fail!',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.black54));
                }
              }
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.book_outlined),
              onPressed: () {
                // handle the press
              },
            ),
            IconButton(
              icon: const Icon(Icons.star_border_outlined),
              onPressed: () {
                // handle the press
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert_outlined),
              onPressed: () {
                // handle the press
              },
            ),
          ],
          title: TextField(
            autofocus: true,
            controller: tittleTextFieldController,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          )),
      body: Center(
          child: Column(children: <Widget>[
        Expanded(
          child: TextField(
            controller: textFieldController,
            expands: true,
            maxLines: null,
            autocorrect: true,
            cursorColor: Colors.purple[900],
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: InputBorder.none,
            ),
            onChanged: (newValue) {},
          ),
          flex: 12,
        ),
        Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.people_alt_outlined),
                  onPressed: () {
                    // handle the press
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.check_box_outlined),
                  onPressed: () {
                    // handle the press
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.text_fields_outlined),
                  onPressed: () {
                    // handle the press
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.text_format_outlined),
                  onPressed: () {
                    // handle the press
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.accessibility_outlined),
                  onPressed: () {
                    // handle the press
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.undo_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.redo_outlined),
                  onPressed: () {},
                ),
              ],
            ),
            flex: 1),
      ])),
    );
  }
}
