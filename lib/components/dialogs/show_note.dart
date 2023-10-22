import 'package:flutter/material.dart';

class ShowNoteDetailsDialog extends StatefulWidget {
  ShowNoteDetailsDialog({super.key, required this.note});

  Map note = {};

  @override
  State<ShowNoteDetailsDialog> createState() => _ShowNoteDetailsDialogState();
}

class _ShowNoteDetailsDialogState extends State<ShowNoteDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.65),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.note['title'] == ""
                      ? Container()
                      : Text(
                          "${widget.note['title']}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                  widget.note['title'] == ''
                      ? Container()
                      : const Divider(
                          color: Colors.brown,
                        ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${widget.note['content']}",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: -5,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.brown,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
