import 'package:app/app/bloc/authenticated/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Story extends StatelessWidget {
  const Story({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(UserData());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UserLoaded) {
          return Center(
              child: Column(
            children: [
              Text(state.models.user.name),
            ],
          ));
        }
        return Container();
      },
    );
  }
}
