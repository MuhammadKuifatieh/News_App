import 'dart:async';

import 'package:bloc/bloc.dart';

mixin EventWithReload {
  bool _isReload = false;
  bool get isReload => _isReload;
  set isReload(bool isReload) {
    _isReload = isReload;
  }
}

///The event must inherit from the EventWithReload mixin class
EventTransformer<T> droppableProMax<T extends EventWithReload>() {
  return (events, mapper) {
    return events.transform(_ExhaustMapStreamTransformer<T>(mapper));
  };
}

class _ExhaustMapStreamTransformer<T> extends StreamTransformerBase<T, T> {
  final EventMapper<T> mapper;

  _ExhaustMapStreamTransformer(this.mapper);
  @override
  Stream<T> bind(Stream<T> stream) {
    late StreamSubscription<T> subscription;
    StreamSubscription<T>? mappedSubscription;

    final controller = StreamController<T>(
      onCancel: () async {
        await mappedSubscription?.cancel();
        return subscription.cancel();
      },
      sync: true,
    );

    subscription = stream.listen(
      (data) {
        final event = data as EventWithReload;
        if (mappedSubscription != null && event.isReload != true) return;
        if (event.isReload) {
          mappedSubscription?.cancel();
        }
        final Stream<T> mappedStream;
        mappedStream = mapper(data);
        mappedSubscription = mappedStream.listen(
          controller.add,
          onError: controller.addError,
          onDone: () => mappedSubscription = null,
        );
      },
      onError: controller.addError,
      onDone: () => mappedSubscription ?? controller.close(),
    );

    return controller.stream;
  }
}
