import 'package:flutter/material.dart';
import 'package:state_using_stream/bloc/counter_bloc.dart';
import 'package:state_using_stream/bloc/counter_event.dart';
import 'package:state_using_stream/bloc/counter_state.dart';
import 'package:state_using_stream/spider_bloc_custom/spider_bloc_builder/spider_bloc_builder.dart';
import 'package:state_using_stream/spider_bloc_custom/spider_bloc_listener/spider_bloc_listener.dart';
import 'package:state_using_stream/spider_provider/spider_inheritance/spider_inheritance.dart';
import 'package:state_using_stream/spider_provider/spider_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return SpiderProvider<CounterBloc>(
      create: () => CounterBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final CounterBloc _counterBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
        _counterBloc = SpiderInheritance.of<CounterBloc>(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            SpiderBlocListener<CounterBloc, CounterState>(
  listenWhen: (previous, current) => previous.count != current.count,
  listener: (context, state) {
    if (state.count > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('больше 5: ${state.count}'),
        ),
      );
    }
  },
  child: SpiderBlocBuilder<CounterBloc, CounterState>(
    builder: (context, snapshot) {
      return Text(
        snapshot.count.toString(),
        style: Theme.of(context).textTheme.headlineMedium,
      );
    },
  ),
),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _counterBloc.addEvent(IncrementEvent()),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
