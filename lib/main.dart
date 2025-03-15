import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewModels/vesselViewModel.dart';
import 'auth/loginOrRegister.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VesselViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginOrRegister());
  }
}
