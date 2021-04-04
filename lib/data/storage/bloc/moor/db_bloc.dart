/*
 * Copyright (c) 2020 - 2021 : William Todt
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:receipt_manager/data/storage/bloc/moor/db_event.dart';
import 'package:receipt_manager/data/storage/bloc/moor/db_state.dart';

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

  /// Perform insert event in database {Repository}.
  Stream<DbState> _mapInsertEventToState(InsertEvent event) async* {
    await _repository.insertReceipt(event.receipt);
  }

  /// Fetch all stored receipts
  Stream<DbState> _mapTaskAllFetchToState() async* {
    yield LoadingState();

    try {
      final receipts = await _repository.getReceipts();
      yield LoadedState(receipts: receipts);
    } catch (_) {
      yield ErrorState();
    }
  }

  /// Perform delete event in database {Repository}.
  Stream<DbState> _mapDeleteEventToState(DeleteEvent event) async* {
    await _repository.deleteReceipt(event.receipt);
  }

  /// Wipe complete database using the
  /// database {Repository}.
  Stream<DbState> _mapDeleteAllEventToState() async* {
    await _repository.deleteDatabase();
  }

  /// Perform update event in database {Repository}.
  Stream<DbState> _mapUpdateEventToState(UpdateEvent event) async* {
    await _repository.updateReceipt(event.receipt);
  }

  /// Fetch all stored receipts
  Stream<DbState> _mapSwitchButtonEventToState() async* {
    yield LoadingState();

    try {
      final receipts = await _repository.getReceipts();
      yield LoadedState(receipts: receipts);
    } catch (_) {
      yield ErrorState();
    }
  }
}
