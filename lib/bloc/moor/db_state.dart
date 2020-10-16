import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receipt_parser/database/receipt_database.dart';

@immutable
abstract class DbState extends Equatable {
  DbState([List props = const []]);
}

class InitialState extends DbState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoadingState extends DbState {
  @override
  String toString() => "LoadingState";

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

// ignore: must_be_immutable
class LoadedState extends DbState {
  List<Receipt> receipt;

  LoadedState({this.receipt}) : super([receipt]);

  @override
  String toString() => "LoadingState";

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ErrorState extends DbState {
  @override
  String toString() => "ErrorState";

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
