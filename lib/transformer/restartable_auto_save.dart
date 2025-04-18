import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_using_stream/transformer/time_limit.dart';

EventTransformer<Event> restartableAutoSave<Event>(Duration duration) {
  return (events, mapper) => events.transform(TimeLimit(duration)).switchMap(mapper);
}
