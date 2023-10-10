import 'package:app/app/bloc/authenticated/auth_bloc.dart';
import 'package:app/app/repositories/auth/api.dart';
import 'package:app/resources/views/dashboard/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  final ApiDataSource apiDataSource;
  const MainScreen({super.key, required this.apiDataSource});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) {
          return AuthBloc(
            repositories: apiDataSource,
          );
        },
        child: const Home(),
      ),
    );
  }
}
