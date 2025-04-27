
typedef EventTransformer<E> = Stream<E> Function(
  Stream<E> events,
  Stream<E> Function(E event) mapper,
);
EventTransformer<Event> initialTransformer<Event>() {
  return (events, mapper) => events.asyncExpand(mapper);
}