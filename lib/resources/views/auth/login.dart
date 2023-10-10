part of 'pages.dart';

class LoginPage extends StatefulWidget {
  final ApiDataSource apiDataSource;
  const LoginPage({super.key, required this.apiDataSource});

  @override
  State<LoginPage> createState() => _LoginPageState(apiDataSource);
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState(ApiDataSource apiDataSource);
  final _loginFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _onLoginButtonPressed() {
      if (_loginFormKey.currentState!.validate()) {
        final request = RequestLogin(
            email: emailController.text, password: passwordController.text);
        BlocProvider.of<LoginBloc>(context)
            .add(LoginButtonPressed(requestLogin: request));
      }
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xffEEF1F3),
            body: Column(
              children: [
                const PageHeader(),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _loginFormKey,
                        child: Column(
                          children: [
                            const PageHeading(title: 'Login'),
                            CustomInputField(
                              controller: emailController,
                              labelText: 'Email',
                              hintText: 'Your email id',
                              validator: (textValue) {
                                if (textValue == null || textValue.isEmpty) {
                                  return 'Email is required!';
                                }
                                if (!EmailValidator.validate(textValue)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomInputField(
                              controller: passwordController,
                              labelText: 'Password',
                              hintText: 'Your password',
                              obscureText: true,
                              suffixIcon: true,
                              validator: (textValue) {
                                if (textValue == null || textValue.isEmpty) {
                                  return 'Password is required!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: size.width * 0.80,
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()))
                                },
                                child: const Text(
                                  'Forget password?',
                                  style: TextStyle(
                                    color: Color(0xff939393),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomFormButton(
                                    innerText: 'Login',
                                    onPressed: _onLoginButtonPressed),
                            const SizedBox(
                              height: 18,
                            ),
                            SizedBox(
                              width: size.width * 0.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an account ? ',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xff939393),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterRoute(
                                                    apiDataSource:
                                                        ApiDataSource(),
                                                  )))
                                    },
                                    child: const Text(
                                      'Sign-up',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff748288),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
