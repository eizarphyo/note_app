import 'package:flutter/material.dart';
import 'package:note_app/providers/loading_provider.dart';
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

  _createNote(NoteProvider provider, LoadingProvider loader) async {
    loader.loading = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Map note = {"title": _titleCtrl.text, "content": _contentCtrl.text};

    final token = prefs.getString('token');

    try {
      final responseNote = await createNoteApi(note, token!);
      debugPrint('$responseNote');
      provider.recallApi();
    } catch (err) {
      debugPrint('$err');
    } finally {
      loader.loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final NoteProvider noteProvider = Provider.of<NoteProvider>(context);
    final LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Create Note",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              TextField(
                controller: _titleCtrl,
                autofocus: true,
                onChanged: (val) {
                  setState(() {});
                },
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
                onChanged: (val) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Description \n\n",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              FilledButton(
                  onPressed: _titleCtrl.text == "" && _contentCtrl.text == ""
                      ? null
                      : () {
                          Navigator.pop(context);
                          _createNote(noteProvider, loadingProvider);
                        },
                  child: const Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
