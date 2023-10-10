import 'package:app/app/bloc/authenticated/auth_bloc.dart';
import 'package:app/app/models/auth/request/request_register.dart';
import 'package:app/app/models/auth/response/response_token.dart';
import 'package:app/app/repositories/auth/api.dart';
import 'package:app/app/repositories/auth/api_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ApiDataSource apiDataSource;
  final AuthBloc authBloc;
  RegisterBloc({required this.apiDataSource, required this.authBloc})
      : super(RegisterInitial()) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterLoading());
      try {
        ApiResponse response =
            await apiDataSource.register(event.requestRegister);
        final tokentype = response.data as Response;
        print(' data ${tokentype.token}');
        authBloc.add(LoggedIn(token: tokentype.token));
        emit(RegisterInitial());
      } catch (error) {
        emit(const RegisterFailure(error: 'errors'));
      }
    });
  }
}
