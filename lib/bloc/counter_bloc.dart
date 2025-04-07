import 'package:state_using_stream/bloc/counter_event.dart';
import 'package:state_using_stream/bloc/counter_state.dart';
import 'package:state_using_stream/stream/stream_bloc_custom.dart';

class CounterBloc extends StreamBlocCustom<CounterEvent, CounterState> {
  CounterBloc()
      : super(
          state: const CounterState(0),
        );

  @override
  void listenEvent(CounterEvent event) {
    if (event is IncrementEvent) {
      int count = state.count;
      count++;
      emit(CounterState(count));
    } else if (event is DecrementEvent) {
      int count = state.count.toInt();
      emit(CounterState(count -= 1));
    }
  }
}
