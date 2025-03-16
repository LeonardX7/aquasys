import 'package:flutter/material.dart';
import '../components/customTile.dart';
import '../pages/Vessel/vesselListPage.dart';
import '../components/theme.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _allModules = [
    {
      'text': 'Vessel',
      'icon': Icons.directions_boat,
      'onTap': VesselListPage(),
    },
    {
      'text': 'Cargo', 
      'icon': Icons.inventory,
      'onTap': null, // To be implemented
    },
    {
      'text': 'Inspection',
      'icon': Icons.search_outlined, 
      'onTap': null, // To be implemented
    },
  ];
  List<Map<String, dynamic>> _foundModules = [];

  @override
  initState() {
    _foundModules = _allModules;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allModules;
    } else {
      results = _allModules
          .where((module) => module["text"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundModules = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Text(
              'Hello, ',
              style: TextStyle(
                fontSize: 16,
                color: theme.colorScheme.surface,
              ),
            ),
            Text(
              'User',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.surface,
              ),
            ),
          ],
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                  hintText: 'Search Module',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'MODULES',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _foundModules.length,
                itemBuilder: (context, index) => CustomTile(
                  text: _foundModules[index]['text'],
                  icon: _foundModules[index]['icon'],
                  onTap: () {
                    if (_foundModules[index]['onTap'] != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => _foundModules[index]['onTap'],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
