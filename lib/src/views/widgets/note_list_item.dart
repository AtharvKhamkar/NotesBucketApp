// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:notesbucket/src/res/model/note.dart';
import 'package:notesbucket/src/res/services/local_db.dart';
import 'package:notesbucket/src/views/create_note.dart';

class NoteListItem extends StatefulWidget {
  const NoteListItem({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  State<NoteListItem> createState() => _NoteListItemState();
}

class _NoteListItemState extends State<NoteListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onLongPress: () {
            LocalDBServices().deleteNote(id: widget.note!.id);
          },
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                
                builder: (context) => CreateNoteView(
                  note: widget.note,
                ),
              ),
              
            );
          },
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0.0,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.note.title,
                        style: GoogleFonts.poppins(fontSize: 18),
                        maxLines: 1,
                      ),
                      Text(
                        widget.note.description,
                        style: GoogleFonts.poppins(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
