import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesbucket/src/res/model/note.dart';
import 'package:notesbucket/src/res/services/local_db.dart';
import 'package:notesbucket/src/views/create_note.dart';

class NoteGridItem extends StatefulWidget {
  const NoteGridItem({super.key, required this.note});

  final Note note;

  @override
  State<NoteGridItem> createState() => _NoteGridItemState();
}

class _NoteGridItemState extends State<NoteGridItem> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onLongPress: (){
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0.0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 2,
            )),
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
                Flexible(
                  child: Text(
                    widget.note.description,
                    style: GoogleFonts.poppins(),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
