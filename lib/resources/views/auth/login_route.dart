part of 'pages.dart';

class LoginRoute extends StatelessWidget {
  final ApiDataSource apiDataSource;
  const LoginRoute({super.key, required this.apiDataSource});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              repositories: apiDataSource,
              authBloc: BlocProvider.of<AuthBloc>(context));
        },
        child: LoginPage(apiDataSource: apiDataSource),
      ),
    );
  }
}
