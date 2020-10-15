import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receipt_parser/database//receipt_database.dart';

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
  Receipt receipt;

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
