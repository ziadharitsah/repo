part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final RequestRegister requestRegister;

  const RegisterButtonPressed({required this.requestRegister});

  @override
  List<Object> get props => [requestRegister];

  @override
  String toString() => 'RegisterButtonPressed $requestRegister';
}
