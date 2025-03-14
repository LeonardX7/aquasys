import 'package:flutter/material.dart';
import '../../components/customFloatMenu.dart';
import 'vesselRegisterPage.dart';

class VesselListPage extends StatefulWidget {
  const VesselListPage({super.key});

  @override
  State<VesselListPage> createState() => _VesselListPageState();
}

class _VesselListPageState extends State<VesselListPage> {
  final List<Map<String, dynamic>> vessels = [
    {
      'name': 'MORINA',
      'registry': 'Port Registry: I.M.O',
      'owner': 'Owner',
      'flag': '🇨🇭',
      'imageUrl': 'https://exemplo.com/morina.jpg' // URL da imagem do navio
    },
    {
      'name': 'ONE AMAZON',
      'registry': 'Port Registry: I.M.O', 
      'owner': 'Owner: MAERSK',
      'flag': '🇩🇰',
      'imageUrl': 'https://exemplo.com/amazon.jpg'
    },
    {
      'name': 'CAP SERRAT',
      'registry': 'Port Registry: I.M.O',
      'owner': 'Owner: COSCO',
      'flag': '🇨🇳',
      'imageUrl': 'https://imgur.com/iSPlDod' // URL corrigida para imagem direta
    },
    {
      'name': 'STENA',
      'registry': 'Port Registry: I.M.O',
      'owner': 'Owner: HAPAG-LLOYD',
      'flag': '🇪🇸',
      'imageUrl': 'https://exemplo.com/stena.jpg'
    },
    {
      'name': 'JUBILANT',
      'registry': 'Port Registry: I.M.O',
      'owner': 'Owner: ONE',
      'flag': '🇵🇦',
      'imageUrl': 'https://exemplo.com/jubilant.jpg'
    },
    {
      'name': 'SHOVELER',
      'registry': 'Port Registry: I.M.O',
      'owner': 'Owner: ONE', 
      'flag': '🇰🇷',
      'imageUrl': 'https://exemplo.com/shoveler.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navios', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Implementar filtros
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: vessels.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                // Imagem do navio
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                  child: vessels[index]['imageUrl'] != null
                      ? Image.network(
                          vessels[index]['imageUrl']!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.image_not_supported, size: 50),
                            );
                          },
                        )
                      : const Center(
                          child: Icon(Icons.directions_boat, size: 50),
                        ),
                ),
                ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        vessels[index]['flag'] ?? '',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  title: Text(
                    vessels[index]['name'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(vessels[index]['registry'] ?? ''),
                      Text(vessels[index]['owner'] ?? ''),
                    ],
                  ),
                  onTap: () {
                    // Implementar navegação para detalhes do navio
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: CustomFloatMenu(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VesselRegisterPage()),
          );
        },
        icon: Icons.add,
      ),
    );
  }
}
