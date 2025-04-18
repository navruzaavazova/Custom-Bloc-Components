import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_using_stream/note/bloc/note_bloc.dart';
import 'package:state_using_stream/note/database/set_up_isar.dart';
import 'package:state_using_stream/note/view/note_list_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await _setUp();
  runApp(const MyApp());
}


Future<void> _setUp() async {
  await SetUpIsar.setUp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NoteListPage(),
      ),
    );
  }
}
