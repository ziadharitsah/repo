// part of 'pages.dart';

// class ForgotPasswordPage extends StatefulWidget {
//   final ApiDataSource repositories;
//   const ForgotPasswordPage({super.key, required this.repositories});


//   @override
//   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final _forgetPasswordFormKey = GlobalKey<FormState>();
//   TextEditingController emailController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xffEEF1F3),
//         body: Column(
//           children: [
//             const PageHeader(),
//             Expanded(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(20),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Form(
//                     key: _forgetPasswordFormKey,
//                     child: Column(
//                       children: [
//                         const PageHeading(
//                           title: 'Forgot password',
//                         ),
//                         CustomInputField(
//                             controller: emailController,
//                             labelText: 'Email',
//                             hintText: 'Your email id',
//                             isDense: true,
//                             validator: (textValue) {
//                               if (textValue == null || textValue.isEmpty) {
//                                 return 'Email is required!';
//                               }
//                               if (!EmailValidator.validate(textValue)) {
//                                 return 'Please enter a valid email';
//                               }
//                               return null;
//                             }),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         CustomFormButton(
//                           innerText: 'Submit',
//                           onPressed: _handleForgetPassword,
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Container(
//                           alignment: Alignment.center,
//                           child: GestureDetector(
//                             onTap: () => {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const LoginPage(repositories: repos)))
//                             },
//                             child: const Text(
//                               'Back to login',
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Color(0xff939393),
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _handleForgetPassword() {
//     // forget password
//     if (_forgetPasswordFormKey.currentState!.validate()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Submitting data..')),
//       );
//     }
//   }
// }
