import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';

import '../../repository/repository.dart';

class DbBloc extends Bloc<DbEvent, DbState> {
  final Repository _repository;

  DbBloc({Repository repository})
      : assert(repository != null),
        _repository = repository,
        super(null);

  DbState get initialState => InitialState();

  @override
  Stream<DbState> mapEventToState(
    DbEvent event,
  ) async* {
    if (event is InsertEvent) {
      yield* _mapInsertEventToState(event);
    } else if (event is ReceiptAllFetch) {
      yield* _mapTaskAllFetchToState();
    } else if (event is DeleteEvent) {
      yield* _mapDeleteEventToState(event);
    } else if (event is UpdateEvent) {
      yield* _mapUpdateEventToState(event);
    } else if (event is SwitchButtonEvent) {
      yield* _mapSwitchButtonEventToState();
    }
  }

  Stream<DbState> _mapInsertEventToState(InsertEvent event) async* {
    await _repository.insertReceipt(event.receipt);
  }

  Stream<DbState> _mapTaskAllFetchToState() async* {
    yield LoadingState();

    try {
      final receipts = await _repository.getReceipts();
      yield LoadedState(receipt: receipts);
    } catch (_) {
      yield ErrorState();
    }
  }

  Stream<DbState> _mapDeleteEventToState(DeleteEvent event) async* {
    await _repository.deleteReceipt(event.receipt);
  }

  Stream<DbState> _mapUpdateEventToState(UpdateEvent event) async* {
    await _repository.updateReceipt(event.receipt);
  }

  Stream<DbState> _mapSwitchButtonEventToState() async* {
    yield LoadingState();

    try {
      final receipts = await _repository.getReceipts();
      yield LoadedState(receipt: receipts);
    } catch (_) {
      yield ErrorState();
    }
  }
}
