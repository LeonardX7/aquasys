import 'package:flutter/material.dart';
import '../../components/customFloatMenu.dart';
import 'vesselRegisterPage.dart';
import '../../viewModels/vesselViewModel.dart';
import 'package:provider/provider.dart';

class VesselListPage extends StatefulWidget {
  const VesselListPage({super.key});

  @override
  State<VesselListPage> createState() => _VesselListPageState();
}

class _VesselListPageState extends State<VesselListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VesselViewModel>(context, listen: false).loadVessels();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vesselViewModel = Provider.of<VesselViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vessels',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Implement filters
            },
          ),
        ],
      ),
      body: vesselViewModel.vessels.isEmpty
          ? ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
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
                        child: const Center(
                          child: Icon(Icons.directions_boat, size: 50, color: Colors.grey),
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
                        ),
                        title: Container(
                          height: 20,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Container(
                              height: 15,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 15,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 15,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: vesselViewModel.vessels.length,
              itemBuilder: (context, index) {
                final vessel = vesselViewModel.vessels[index];
                return Dismissible(
                  key: Key(vessel.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Deletion'),
                          content: const Text('Are you sure you want to delete this vessel?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    vesselViewModel.deleteVessel(vessel.id!);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
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
                          child: vessel.imageUrl != null
                              ? Image.network(vessel.imageUrl!, fit: BoxFit.cover)
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
                              child: Text(vessel.flag,
                                  style: const TextStyle(fontSize: 32)),
                            ),
                          ),
                          title: Text(
                            vessel.vesselName.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                'Port Registry: ${vessel.portRegistry}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'I.M.O: ${vessel.IMO}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Owner: ${vessel.owner}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                          onTap: () {
                            // Implement vessel details navigation
                          },
                        ),
                      ],
                    ),
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
