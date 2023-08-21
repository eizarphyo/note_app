import 'package:flutter/material.dart';
import 'package:note_app/components/note.dart';
import 'package:note_app/models.dart/note_model.dart';
import 'package:note_app/network/note_api.dart';
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

      // if (auth.uid != null) {
      //   noteProvider.getNotes(auth.uid!);
      // } else {
      //   debugPrint("AUTH UID IS NULL");
      // }
      // callApiandShowNotes(auth.uid);
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
            child: Text("You haven't added any notes yet.."),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: ListView.builder(
                itemCount: noteProvider.notes.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      //   child: NoteComponent(
                      //     note: notes[index],
                      //   ),
                      // );
                      child: GestureDetector(
                        onTap: () {
                          _showDialog(ShowNoteDetailsDialog());
                        },
                        child: Container(
                          // width: MediaQuery.of(context).size.width * 0.8,
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          // constraints: BoxConstraints(
                          //   maxWidth: MediaQuery.of(context).size.width * 0.5,
                          // ),
                          decoration: BoxDecoration(
                            color: Colors.brown.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${noteProvider.notes[index]['title']}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  // Expanded(child: Text("${notes[index]['title']}")),
                                  PopupMenuButton(
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
                                                _showDialog(EditNoteDialog());
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
                                ],
                              ),
                              const Divider(
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
