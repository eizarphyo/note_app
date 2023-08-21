import 'package:flutter/material.dart';

class ShowNoteDetailsDialog extends StatefulWidget {
  const ShowNoteDetailsDialog({super.key});

  @override
  State<ShowNoteDetailsDialog> createState() => _ShowNoteDetailsDialogState();
}

class _ShowNoteDetailsDialogState extends State<ShowNoteDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.65),
        child: Stack(
          children: [
            const SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Title Bla Bla"),
                  Divider(
                    color: Colors.brown,
                  ),
                  Text(
                      "bla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblaaaaaaaaaaaaaaaaaaaaaa"),
                ],
              ),
            ),
            Positioned(
                right: -15,
                top: -15,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)))
          ],
        ),
      ),
    );
  }
}
