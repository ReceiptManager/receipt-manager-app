import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receipt_parser/database//receipt_database.dart';

@immutable
abstract class DbEvent extends Equatable {
  DbEvent([List props = const []]) : super(props);
}

class StartAppEvent extends DbEvent {
  @override
  String toString() => "StartAppEvent";
}

class InsertEvent extends DbEvent {
  Receipt receipt;

  InsertEvent({this.receipt}) : super([receipt]);

  @override
  String toString() => "InsertEvent : $receipt";
}

class UpdateEvent extends DbEvent {
  Receipt receipt;

  UpdateEvent({this.receipt}) : super([receipt]);

  @override
  String toString() => "UpdateEvent";
}

class SwitchButtonEvent extends DbEvent {
  @override
  String toString() => "SwitchButtonEvent";
}

// ignore: must_be_immutable
class DeleteEvent extends DbEvent {
  Receipt receipt;

  DeleteEvent({this.receipt}) : super([receipt]);

  @override
  String toString() => "DeleteEvent - $receipt";
}

class ReceiptWatchEvent {
  @override
  String toString() => "ReceiptWatchEvent";
}

//notify the bloc fetch all the record form db
class ReceiptAllFetch extends DbEvent {
  @override
  String toString() => "ReceiptAllFetch";
}
