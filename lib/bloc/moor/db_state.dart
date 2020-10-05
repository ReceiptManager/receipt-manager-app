import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receipt_parser/db/receipt_database.dart';

@immutable
abstract class DbState extends Equatable {
  DbState([List props = const []]) : super(props);
}

class InitialState extends DbState {}

class LoadingState extends DbState {
  @override
  String toString() => "LoadingState";
}

class LoadedState extends DbState {
  List<Receipt> receipt;

  LoadedState({this.receipt}) : super([receipt]);

  @override
  String toString() => "LoadingState";
}

class ErrorState extends DbState {
  @override
  String toString() => "ErrorState";
}
