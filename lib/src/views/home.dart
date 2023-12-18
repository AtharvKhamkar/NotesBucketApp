import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:notesbucket/src/res/assets.dart';
import 'package:notesbucket/src/res/model/note.dart';
import 'package:notesbucket/src/res/services/local_db.dart';
import 'package:notesbucket/src/res/string.dart';
import 'package:notesbucket/src/views/create_note.dart';
import 'package:notesbucket/src/views/widgets/empty_view.dart';
import 'package:notesbucket/src/views/widgets/note_list_item.dart';
import 'package:notesbucket/src/views/widgets/notes_grid.dart';
import 'package:notesbucket/src/views/widgets/notes_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isListView = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.appName,
                    style: GoogleFonts.poppins(fontSize: 24),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isListView = !isListView;
                        });
                      },
                      icon: Icon(isListView
                          ? Icons.splitscreen_outlined
                          : Icons.grid_view))
                ],
              ),
            ),
            //const EmptyView()
            StreamBuilder<List<Note>>(
                stream: LocalDBServices().listenAllNotes(),
                builder: (context, snapshot) {
                  final notes = snapshot.data!;
                  if (notes.length == 0) {
                    return EmptyView();
                  }

                  if (isListView) {
                    return NotesList(notes: notes);
                  }
                  return NotesGrid(notes: notes);
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CreateNoteView(),
          ));
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      ),
    );
  }
}
