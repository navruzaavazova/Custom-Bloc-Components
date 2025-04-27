import 'package:flutter/material.dart';
import 'package:state_using_stream/presentation/note/bloc/note_bloc.dart';
import 'package:state_using_stream/presentation/note/database/set_up_isar.dart';
import 'package:state_using_stream/presentation/note/view/note_list_page.dart';
import 'package:state_using_stream/base/spider_provider/spider_provider.dart';

import 'package:get_it/get_it.dart';
GetIt getIt = GetIt.instance;


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
    return SpiderProvider(
      create: () => NoteBloc(),
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
