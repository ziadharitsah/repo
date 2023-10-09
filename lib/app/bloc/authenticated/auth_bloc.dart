import 'package:app/app/models/auth/response/response_token.dart';
import 'package:app/app/repositories/auth/api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiDataSource repositories;
  AuthBloc({required this.repositories}) : super(AuthenticationInit()) {
    on<AppStarted>((event, emit) async {
      emit(AuthenticationLoading());
      final bool hasToken = await repositories.hasToken();
      print(' has ${hasToken.toString()}');
      if (hasToken) {
        emit(AuthenticationAuthenticated());
        // print(hasToken);
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthenticationLoading());
      await repositories.persistToken(event.token);
      emit(AuthenticationAuthenticated());
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthenticationLoading());
      await repositories.deleteToken();
      emit(AuthenticationUnauthenticated());
    });
  }
}
