part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthenticationInit extends AuthState {}

class AuthenticationUninitialized extends AuthState {}

class AuthenticationAuthenticated extends AuthState {}

class AuthenticationUnauthenticated extends AuthState {}

class AuthenticationLoading extends AuthState {}

class UserLoaded extends AuthState {
  final ResponseUser models;

  const UserLoaded({required this.models});
  @override
  List<Object> get props => [models];
}
