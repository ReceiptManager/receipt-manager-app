/*
 * Copyright (c) 2020 - William Todt
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
    } else if (event is DeleteAllEvent) {
      yield* _mapDeleteAllEventToState();
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

  Stream<DbState> _mapDeleteAllEventToState() async* {
    await _repository.deleteDatabase();
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
