import 'package:app/app/bloc/authenticated/auth_bloc.dart';
import 'package:app/app/models/auth/request/request_login.dart';
import 'package:app/app/models/auth/response/response_token.dart';
import 'package:app/app/repositories/auth/api.dart';
import 'package:app/app/repositories/auth/api_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiDataSource repositories;
  final AuthBloc authBloc;
  LoginBloc({required this.repositories, required this.authBloc})
      : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        ApiResponse response = await repositories.login(event.requestLogin);
        final tokentype = response.data as Response;
        print(' data ${tokentype.token}');
        authBloc.add(LoggedIn(token: tokentype.token));
        emit(LoginInitial());
      } catch (error) {
        emit(const LoginFailure(error: 'errors'));
      }
    });
  }
}
