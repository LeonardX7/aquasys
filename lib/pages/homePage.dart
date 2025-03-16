import 'package:flutter/material.dart';
import '../components/customFloatMenu.dart';
import '../pages/menuPage.dart';
import '../components/customWeather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Aquasys',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: const Stack(
        children: [
          CustomWeather(),
        ],
      ),
      floatingActionButton: CustomFloatMenu(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MenuPage()),
          );
        },
      ),
    );
  }
}
