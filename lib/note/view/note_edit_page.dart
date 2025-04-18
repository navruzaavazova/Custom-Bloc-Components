import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_using_stream/note/bloc/note_bloc.dart';
import 'package:state_using_stream/note/models/note_model.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({super.key, required this.note});
  final NoteModel note;

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
     super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);

    _titleController.addListener(() {
      context
          .read<NoteBloc>()
          .add(AutoSaveNote(widget.note..title = _titleController.text));
    });

    _contentController.addListener(() {
      context
          .read<NoteBloc>()
          .add(AutoSaveNote(widget.note..content = _contentController.text));
    });


  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteSaved) return const Text("Saved");
            return const Text("Edit Note");
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Write your note...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { context.read<NoteBloc>()
          .add(
            SaveNote(widget.note),
          );

          Navigator.pop(context);
        },
        child: const Icon(Icons.save_as_sharp),
      ),
    );
  }
}
