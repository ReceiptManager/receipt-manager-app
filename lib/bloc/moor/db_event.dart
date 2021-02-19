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
import 'package:receipt_manager/database/receipt_database.dart';

@immutable
abstract class DbEvent extends Equatable {
  DbEvent([List props = const []]);
}

class StartAppEvent extends DbEvent {
  @override
  String toString() => "StartAppEvent";

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class InsertEvent extends DbEvent {
  final ReceiptsCompanion receipt;

  InsertEvent({this.receipt}) : super([receipt]);

  @override
  String toString() => "InsertEvent : $receipt";

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class UpdateEvent extends DbEvent {
  final Receipt receipt;

  UpdateEvent({this.receipt}) : super([receipt]);

  @override
  String toString() => "UpdateEvent";

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class SwitchButtonEvent extends DbEvent {
  @override
  String toString() => "SwitchButtonEvent";

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class DeleteEvent extends DbEvent {
  final Receipt receipt;

  DeleteEvent({this.receipt}) : super([receipt]);

  @override
  String toString() => "DeleteEvent - $receipt";

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class DeleteAllEvent extends DbEvent {
  @override
  String toString() => "DeleteAllEvent";

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ReceiptWatchEvent {
  @override
  String toString() => "ReceiptWatchEvent";
}

class ReceiptAllFetch extends DbEvent {
  @override
  String toString() => "ReceiptAllFetch";

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
