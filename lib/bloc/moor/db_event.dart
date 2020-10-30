/*
 *  Copyright (c) 2020 - William Todt
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
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
