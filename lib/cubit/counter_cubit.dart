import 'package:state_using_stream/cubit/counter_state.dart';
import 'package:state_using_stream/stream/cubit_custom.dart';

class CounterCubit extends CubitCustom<CounterState> {
  CounterCubit()
      : super(
          state: const CounterState(0),
        );

  void increment() {
    emit(CounterState(state.count + 1));
  }

  void decrement() {
    emit(CounterState(state.count + 1));
  }
}
