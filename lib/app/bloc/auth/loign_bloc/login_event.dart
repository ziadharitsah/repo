part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final RequestLogin requestLogin;

  const LoginButtonPressed({required this.requestLogin});

  @override
  List<Object> get props => [requestLogin];

  @override
  String toString() => 'LoginButtonPressed $requestLogin';
}
