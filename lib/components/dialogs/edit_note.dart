import 'package:flutter/material.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:provider/provider.dart';

class EditNoteDialog extends StatefulWidget {
  EditNoteDialog({
    super.key,
    //  required index
  });

  // late int index;

  @override
  State<EditNoteDialog> createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<EditNoteDialog> {
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    NoteProvider noteProvider = Provider.of<NoteProvider>(context);

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.center,
      title: const Text("Edit Note"),
      content: Container(
        // height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.8,
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
        child: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(border: InputBorder.none),
              ),
              Divider(
                color: Colors.brown,
              ),
              SingleChildScrollView(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Edit")),
      ],
    );
  }
}
