import 'package:flutter/material.dart';

class VesselRegisterPage extends StatefulWidget {
  const VesselRegisterPage({super.key});

  @override
  State<VesselRegisterPage> createState() => _VesselRegisterPageState();
}

class _VesselRegisterPageState extends State<VesselRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vessel Registration', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Vessel Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the vessel name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Place'),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Flag'),
                items: <String>['🇨🇭', '🇩🇰', '🇨🇳', '🇪🇸', '🇵🇦', '🇰🇷']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'I.M.O'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Port Registry'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Date of Building'),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Type Of Ship'),
                items: <String>['Type 1', 'Type 2', 'Type 3']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Owner'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Operator'),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Vessel Images'),
                items: <String>['Image 1', 'Image 2', 'Image 3']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Implementar lógica de envio
                  }
                },
                child: const Text('Next Step'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
