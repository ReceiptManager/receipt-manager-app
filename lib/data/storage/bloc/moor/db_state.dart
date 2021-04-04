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

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receipt_manager/data/storage/receipt_database.dart';

@immutable
abstract class DbState extends Equatable {
  DbState([List props = const []]);
}

class InitialState extends DbState {
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class LoadingState extends DbState {
  @override
  String toString() => "LoadingState";

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// ignore: must_be_immutable
class LoadedState extends DbState {
  List<Receipt> receipts;

  LoadedState({this.receipts}) : super([receipts]);

  @override
  String toString() => "LoadingState";

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ErrorState extends DbState {
  @override
  String toString() => "ErrorState";

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
