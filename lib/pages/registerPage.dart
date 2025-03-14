// import 'package:flutter/material.dart';
// import '../components/theme.dart';
// import '../components/CustomTextField.dart';
// import '../components/customButton.dart';

// class RegisterPage extends StatefulWidget {
//   final Function() onTap;
//   const RegisterPage({super.key, required this.onTap});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController emailController = TextEditingController();
//     TextEditingController loginController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();

//     TextEditingController passwordConfirmController = TextEditingController();

//     return Scaffold(
//       backgroundColor: theme.colorScheme.surface,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Register',
//             style: TextStyle(
//                 fontSize: 45,
//                 fontWeight: FontWeight.bold,
//                 color: theme.colorScheme.primary),
//           ),
//           CustomTextField(
//               controller: emailController,
//               hintText: 'Email',
//               obscureText: false),
//           const SizedBox(height: 5),
//           CustomTextField(
//               controller: loginController,
//               hintText: 'Login',
//               obscureText: false),
//           const SizedBox(height: 5),
//           CustomTextField(
//               controller: passwordController,
//               hintText: 'Password',
//               obscureText: true),
//           const SizedBox(height: 5),
//           CustomTextField(
//               controller: passwordConfirmController,
//               hintText: 'Confirm Password',
//               obscureText: true),
//           const SizedBox(height: 15),
//           CustomButton(
//               text: 'Register',
//               onPressed: () {
//                 print('${emailController.text} ${passwordController.text}');
//               }),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text('Already have an account?'),
//               TextButton(
//                   onPressed: widget.onTap, child: const Text('Login now!'))
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
