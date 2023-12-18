// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:lottie/lottie.dart';
import 'package:notesbucket/src/res/assets.dart';

import 'package:notesbucket/src/res/model/note.dart';
import 'package:notesbucket/src/res/services/local_db.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({
    super.key,
    this.note,
  });

  final Note? note;

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final localDb = LocalDBServices();

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log(_titleController.text);
    log(_descriptionController.text);

    final title = _titleController.text;
    final desc = _descriptionController.text;

    //function to update new node when user click on a particular note
    if (widget.note != null) {
      if (title.isEmpty && desc.isEmpty) {
        localDb.deleteNote(id: widget.note!.id);
      } else if (widget.note!.title != title ||
          widget.note!.description != desc) {
        final newNote = widget.note!.copyWith(
          title: title,
          description: desc,
        );
        localDb.saveNote(note: newNote);
      }
    } else {
      final newNote = Note(
          id: Isar.autoIncrement,
          title: title,
          description: desc,
          lastMod: DateTime.now());
      localDb.saveNote(note: newNote);
    }

    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
              widget.note != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          //Show warning that user is deleting the note
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Delete Note ?",
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      LottieBuilder.asset(
                                          AnimationsAssets.delete),
                                      Text(
                                        "This note will be permanently deleted",
                                        style:
                                            GoogleFonts.poppins(fontSize: 18),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          localDb.deleteNote(
                                              id: widget.note!.id);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Proceed")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel"))
                                  ],
                                );
                              });
                        },
                        icon: const Icon(Icons.delete_outlined),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
              ),
              style: GoogleFonts.poppins(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Description",
              ),
              style: GoogleFonts.poppins(fontSize: 20),
            ),
          )
        ],
      )),
    );
  }
}
