import 'package:app/app/models/auth/response/response_user.dart';
import 'package:app/app/repositories/auth/api.dart';
import 'package:app/app/repositories/auth/api_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiDataSource repositories;
  AuthBloc({required this.repositories}) : super(AuthenticationInit()) {
    on<AppStarted>((event, emit) async {
      emit(AuthenticationLoading());
      final hasToken = await repositories.hasToken();
      print(' has ${hasToken.toString()}');
      if (hasToken != null) {
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

    on<UserData>((event, emit) async {
      ApiResponse user = await repositories.user();
      if (user.error == null) {
        final data = user.data as ResponseUser;
        print(data.user.name);
        emit(UserLoaded(models: data));
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });
  }
}
