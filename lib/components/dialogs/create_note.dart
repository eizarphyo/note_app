import 'package:flutter/material.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/note_api.dart';

class CreateNoteDialog extends StatefulWidget {
  const CreateNoteDialog({super.key});

  @override
  State<CreateNoteDialog> createState() => _CreateNoteDialogState();
}

class _CreateNoteDialogState extends State<CreateNoteDialog> {
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();

  _createNote(NoteProvider provider) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Map note = {
      "title": _titleCtrl.text,
      "content": _contentCtrl.text,
      "uid": prefs.getString('uid')
    };

    try {
      final responseNote = await createNoteApi(note);
      debugPrint('$responseNote');
      provider.recallApi();
    } catch (err) {
      debugPrint('$err');
    }
  }

  @override
  Widget build(BuildContext context) {
    final NoteProvider noteProvider = Provider.of<NoteProvider>(context);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const Divider(
                color: Colors.brown,
              ),
              TextField(
                controller: _contentCtrl,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _createNote(noteProvider);
                  },
                  child: const Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
