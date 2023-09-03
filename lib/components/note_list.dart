import 'package:flutter/material.dart';
import 'package:note_app/providers/auth_provider.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:provider/provider.dart';

import 'dialogs/delete_alert.dart';
import 'dialogs/edit_note.dart';
import 'dialogs/show_note.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  // List notes = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final AuthProvider auth =
          Provider.of<AuthProvider>(context, listen: false);
      final NoteProvider noteProvider =
          Provider.of<NoteProvider>(context, listen: false);

      await noteProvider.getNotes(auth.uid!);
      debugPrint("${noteProvider.notes}");
      debugPrint("AUTH UID FROM NOTE LIST >>> ${auth.uid}");
    });
  }

  // callApiandShowNotes(uid) async {
  //   notes = await getAllNotes(uid);
  //   setState(() {});
  //   debugPrint('$notes');
  // }

  @override
  Widget build(BuildContext context) {
    final NoteProvider noteProvider = Provider.of<NoteProvider>(context);

    return noteProvider.notes.isEmpty
        ? const Center(
            child: Text(
              "Nothing here.. 🍃",
              style: TextStyle(color: Colors.grey),
            ),
          )
        : SizedBox(
            width: MediaQuery.of(context).size.height * 1,
            height: MediaQuery.of(context).size.height * 0.9,
            child: ListView.builder(
                itemCount: noteProvider.notes.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          _showDialog(ShowNoteDetailsDialog(
                            note: noteProvider.notes[index],
                          ));
                        },
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.87,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height * 0.05),
                            decoration: BoxDecoration(
                              color: Colors.brown.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    noteProvider.notes[index]['title'] == ""
                                        ? Container()
                                        : Text(
                                            "${noteProvider.notes[index]['title']}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                    noteProvider.notes[index]['title'] == ""
                                        ? Container()
                                        : const Divider(
                                            color: Colors.brown,
                                          ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${noteProvider.notes[index]['content']}",
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                Positioned(
                                  top: -10,
                                  right: -15,
                                  child: PopupMenuButton(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.28,
                                    ),
                                    itemBuilder: (context) {
                                      return [
                                        // EDIT BUTTON
                                        PopupMenuItem(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 0),
                                            child: TextButton(
                                              onPressed: () {
                                                debugPrint(
                                                    "FROM NOTE LIST >>> ${noteProvider.notes[index]}");
                                                _showDialog(EditNoteDialog(
                                                  note:
                                                      noteProvider.notes[index],
                                                ));
                                              },
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                    Icons.edit,
                                                    size: 18,
                                                  ),
                                                  Text(" Edit")
                                                ],
                                              ),
                                            )),
                                        // DELETE BUTTON
                                        PopupMenuItem(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 0),
                                            child: TextButton(
                                              onPressed: () {
                                                _showDialog(DeleteNoteAlert(
                                                  id: noteProvider.notes[index]
                                                      ['_id'],
                                                ));
                                              },
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .delete_outline_rounded,
                                                    size: 18,
                                                  ),
                                                  Text(" Delete")
                                                ],
                                              ),
                                            )),
                                      ];
                                    },
                                    iconSize: 18,
                                    // position: PopupMenuPosition.over,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                }),
          );
  }

  _showDialog(Widget MyDialog) {
    showDialog(
        context: context,
        builder: (context) {
          return MyDialog;
        });
  }
}
