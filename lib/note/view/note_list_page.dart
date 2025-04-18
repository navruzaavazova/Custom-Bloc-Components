import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_using_stream/note/bloc/note_bloc.dart';
import 'package:state_using_stream/note/models/note_model.dart';
import 'package:state_using_stream/note/view/note_edit_page.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(GetNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NotesInitial) {
            return const Center(
              child: Text("Create note..."),
            );
          } else if (state is NotesLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (_, index) {
                final note = state.notes[index];
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    style: ListTileStyle.drawer,
                    title: Text(
                      note.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NoteEditPage(note: note),
                        ),
                      ).then(
                        (_) => context.read<NoteBloc>().add(GetNotes()),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is NotesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotesError) {
            return Text(state.message);
          }
          return const Center(child: const Text('Whats'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          final noteInitial = NoteModel()
            ..title = ''
            ..content = '';
          context.read<NoteBloc>().add(CreateNote(noteInitial));
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NoteEditPage(note: noteInitial),
              ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
