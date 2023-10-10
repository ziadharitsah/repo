part of 'pages.dart';

class RegisterRoute extends StatelessWidget {
  final ApiDataSource apiDataSource;
  const RegisterRoute({super.key, required this.apiDataSource});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) {
          return RegisterBloc(
              apiDataSource: apiDataSource,
              authBloc: BlocProvider.of<AuthBloc>(context));
        },
        child: const RegisterPage(),
      ),
    );
  }
}
