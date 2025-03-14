import 'package:flutter/material.dart';
import '../components/customTile.dart';
import '../pages/Vessel/vesselListPage.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modules', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search modules...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Modules list
            Expanded(
              child: ListView(
                children: [
                  CustomTile(
                    text: 'Vessel',
                    icon: Icons.directions_boat,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VesselListPage()),
                      );
                    },
                  ),
                  CustomTile(
                    text: 'Cargo',
                    icon: Icons.inventory,
                    onTap: () {
                      // Navigation to Cargo module
                    },
                  ),
                  CustomTile(
                    text: 'Inspection',
                    icon: Icons.search_outlined,
                    onTap: () {
                      // Navigation to Inspection module
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
