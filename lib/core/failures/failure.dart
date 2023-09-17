import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String failureMessage;
  const Failure({
    required this.failureMessage,
});
  @override
  List<Object> get props => [failureMessage];
}