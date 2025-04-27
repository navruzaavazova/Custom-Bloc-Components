import 'package:state_using_stream/presentation/home/cubit/counter_state.dart';
import 'package:state_using_stream/base/spider_bloc_custom/spider_bloc_base/spider_cubit.dart';

class CounterCubit extends SpiderCubit<CounterState> {
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
