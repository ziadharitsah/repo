import 'package:app/app/bloc/authenticated/auth_bloc.dart';
import 'package:app/app/repositories/auth/api.dart';
import 'package:app/resources/views/auth/pages.dart';
import 'package:app/resources/views/dashboard/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

class MyApp extends StatelessWidget {
  final ApiDataSource apiDataSource;
  const MyApp({super.key, required this.apiDataSource});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('id', 'ID'),
      theme: ThemeData(
        fontFamily: 'Rubik',
        primarySwatch: Colors.blueGrey,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return MainScreen(
              apiDataSource: apiDataSource,
            );
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginRoute(apiDataSource: apiDataSource);
          }
          if (state is AuthenticationLoading) {
            return Scaffold(
              body: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25.0,
                      width: 25.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 4.0,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.purple),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  final apidatasource = ApiDataSource();
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) {
        return AuthBloc(repositories: apidatasource)..add(AppStarted());
      },
      child: MyApp(apiDataSource: apidatasource),
    ),
  );
}
