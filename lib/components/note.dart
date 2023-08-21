import 'package:flutter/material.dart';
import 'package:note_app/components/dialogs/delete_alert.dart';
import 'package:note_app/components/dialogs/edit_note.dart';
import 'package:note_app/components/dialogs/show_note.dart';

class NoteComponent extends StatefulWidget {
  NoteComponent({super.key, note});

  Map note = {};

  @override
  State<NoteComponent> createState() => _NoteComponentState();
}

class _NoteComponentState extends State<NoteComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.note == {}
        ? Container()
        : GestureDetector(
            onTap: () {
              _showDialog(ShowNoteDetailsDialog());
            },
            child: Container(
              // width: MediaQuery.of(context).size.width * 0.8,
              width: MediaQuery.of(context).size.width * 0.4,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.brown.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text("${widget.note['title']}")),
                      PopupMenuButton(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.28,
                        ),
                        itemBuilder: (context) {
                          return [
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
                            PopupMenuItem(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                child: TextButton(
                                  onPressed: () {
                                    _showDialog(DeleteNoteAlert(
                                        id: widget.note['_id']));
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.delete_outline_rounded,
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
                  Text(
                    "${widget.note['content']}",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          );

    // return GestureDetector(
    //   onTap: () {
    //     _showDialog(ShowNoteDetailsDialog());
    //   },
    //   child: Container(
    //     width: MediaQuery.of(context).size.width * 0.8,
    //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    //     decoration: BoxDecoration(
    //       color: Colors.brown.shade100,
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //     child: Column(
    //       children: [
    //         Row(
    //           children: [
    //             const Expanded(child: Text("Title")),
    //             PopupMenuButton(
    //               constraints: BoxConstraints(
    //                 maxWidth: MediaQuery.of(context).size.width * 0.28,
    //               ),
    //               itemBuilder: (context) {
    //                 return [
    //                   PopupMenuItem(
    //                       padding: const EdgeInsets.symmetric(
    //                           vertical: 0, horizontal: 0),
    //                       child: TextButton(
    //                         onPressed: () {
    //                           _showDialog(EditNoteDialog());
    //                         },
    //                         child: const Row(
    //                           children: [
    //                             Icon(
    //                               Icons.edit,
    //                               size: 18,
    //                             ),
    //                             Text(" Edit")
    //                           ],
    //                         ),
    //                       )),
    //                   PopupMenuItem(
    //                       padding: const EdgeInsets.symmetric(
    //                           vertical: 0, horizontal: 0),
    //                       child: TextButton(
    //                         onPressed: () {
    //                           _showDialog(DeleteNoteAlert());
    //                         },
    //                         child: const Row(
    //                           children: [
    //                             Icon(
    //                               Icons.delete_outline_rounded,
    //                               size: 18,
    //                             ),
    //                             Text(" Delete")
    //                           ],
    //                         ),
    //                       )),
    //                 ];
    //               },
    //               iconSize: 18,
    //               // position: PopupMenuPosition.over,
    //             ),
    //           ],
    //         ),
    //         const Divider(
    //           color: Colors.brown,
    //         ),
    //         const Text(
    //           "Content",
    //           maxLines: 5,
    //           overflow: TextOverflow.ellipsis,
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  _showDialog(Widget MyDialog) {
    showDialog(
        context: context,
        builder: (context) {
          return MyDialog;
        });
  }

  // _showEditDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           insetPadding: EdgeInsets.zero,
  //           actionsAlignment: MainAxisAlignment.center,
  //           title: const Text("Edit Note"),
  //           content: Container(
  //             // height: MediaQuery.of(context).size.height * 0.2,
  //             width: MediaQuery.of(context).size.width * 0.8,
  //             constraints: BoxConstraints(
  //                 maxHeight: MediaQuery.of(context).size.height * 0.5),
  //             child: const SingleChildScrollView(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   TextField(
  //                     decoration: InputDecoration(border: InputBorder.none),
  //                   ),
  //                   Divider(
  //                     color: Colors.brown,
  //                   ),
  //                   SingleChildScrollView(
  //                     child: TextField(
  //                       keyboardType: TextInputType.multiline,
  //                       maxLines: null,
  //                       decoration: InputDecoration(border: InputBorder.none),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           actions: [
  //             FilledButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text("Save")),
  //           ],
  //         );
  //       });
  // }
  // _showDeleteDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text("Delete Note"),
  //           content: const Text("Are you sure want to delete this note?"),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text("Delete")),
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text("Cancel")),
  //           ],
  //         );
  //       });
  // }
  // _showNote() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           insetPadding: EdgeInsets.symmetric(horizontal: 20),
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //             constraints: BoxConstraints(
  //                 maxHeight: MediaQuery.of(context).size.height * 0.65),
  //             child: Stack(
  //               children: [
  //                 const SingleChildScrollView(
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Text("Title Bla Bla"),
  //                       Divider(
  //                         color: Colors.brown,
  //                       ),
  //                       Text(
  //                           "bla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblabla\nbla\nbla\nblaaaaaaaaaaaaaaaaaaaaaa"),
  //                     ],
  //                   ),
  //                 ),
  //                 Positioned(
  //                     right: -15,
  //                     top: -15,
  //                     child: IconButton(
  //                         onPressed: () {
  //                           Navigator.pop(context);
  //                         },
  //                         icon: const Icon(Icons.close)))
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
}
