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

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receipt_parser/database/receipt_database.dart';

@immutable
abstract class DbEvent extends Equatable {
  DbEvent([List props = const []]);
}

class StartAppEvent extends DbEvent {
  @override
  String toString() => "StartAppEvent";

  @override
  List<Object> get props => throw UnimplementedError();
}

// ignore: must_be_immutable
class InsertEvent extends DbEvent {
  ReceiptsCompanion receipt;

  InsertEvent({this.receipt}) : super([receipt]);

  @override
  String toString() => "InsertEvent : $receipt";

  @override
  List<Object> get props => throw UnimplementedError();
}

// ignore: must_be_immutable
class UpdateEvent extends DbEvent {
  Receipt receipt;

  UpdateEvent({this.receipt}) : super([receipt]);

  @override
  String toString() => "UpdateEvent";

  @override
  List<Object> get props => throw UnimplementedError();
}

class SwitchButtonEvent extends DbEvent {
  @override
  String toString() => "SwitchButtonEvent";

  @override
  List<Object> get props => throw UnimplementedError();
}

// ignore: must_be_immutable
class DeleteEvent extends DbEvent {
  Receipt receipt;

  DeleteEvent({this.receipt}) : super([receipt]);

  @override
  String toString() => "DeleteEvent - $receipt";

  @override
  List<Object> get props => throw UnimplementedError();
}

class DeleteAllEvent extends DbEvent {
  @override
  String toString() => "DeleteAllEvent";

  @override
  List<Object> get props => throw UnimplementedError();
}

class ReceiptWatchEvent {
  @override
  String toString() => "ReceiptWatchEvent";
}

//notify the bloc fetch all the record form db
class ReceiptAllFetch extends DbEvent {
  @override
  String toString() => "ReceiptAllFetch";

  @override
  List<Object> get props => throw UnimplementedError();
}
