part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    _onRegisterButtonPressed() {
      if (_loginFormKey.currentState!.validate()) {
        final request = RequestRegister(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
            passwordConfirmation: passwordConfirmationController.text);
        BlocProvider.of<RegisterBloc>(context)
            .add(RegisterButtonPressed(requestRegister: request));
      }
    }

    Size size = MediaQuery.of(context).size;
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
            ),
          );
        }
      },
      child:
          BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
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
                            const PageHeading(title: 'Sign Up'),
                            CustomInputField(
                              controller: nameController,
                              labelText: 'Name',
                              hintText: 'Your Name',
                              validator: (textValue) {
                                if (textValue == null || textValue.isEmpty) {
                                  return 'Name is required!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
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
                            CustomInputField(
                              controller: passwordConfirmationController,
                              labelText: 'Password Confirmation',
                              hintText: ' Create your password confirmation',
                              isDense: true,
                              obscureText: true,
                              validator: (textValue) {
                                if (textValue == null ||
                                    textValue != passwordController.text) {
                                  return 'Confirm password does not match';
                                }
                                return null;
                              },
                              suffixIcon: true,
                            ),
                            const SizedBox(
                              height: 22,
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
                                    onPressed: _onRegisterButtonPressed),
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
                                                  const Home()))
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
