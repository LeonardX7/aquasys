import 'package:flutter/material.dart';
import '../../viewModels/vesselViewModel.dart';
import 'package:provider/provider.dart';
import '../../components/customToast.dart';
import '../../components/customButton.dart';
import '../../components/customFlagSelector.dart';
import '../../components/customTextFieldForms.dart';

class VesselRegisterPage extends StatefulWidget {
  const VesselRegisterPage({super.key});

  @override
  State<VesselRegisterPage> createState() => _VesselRegisterPageState();
}

class _VesselRegisterPageState extends State<VesselRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _vesselNameController = TextEditingController();
  final _placeController = TextEditingController();
  final _portRegistryController = TextEditingController();
  final _ownerController = TextEditingController();
  final _flagController = TextEditingController();
  final _imoController = TextEditingController();
  final _operatorController = TextEditingController();
  String _selectedFlag = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VesselViewModel>(context, listen: false).loadVessels();
    });
    _flagController.text = _selectedFlag;
  }

  @override
  void dispose() {
    _vesselNameController.dispose();
    _placeController.dispose();
    _portRegistryController.dispose();
    _ownerController.dispose();
    _flagController.dispose();
    _imoController.dispose();
    _operatorController.dispose();
    super.dispose();
  }

  void _showSuccessMessage() {
    CustomToast.show(context, 'Vessel saved successfully!', backgroundColor: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    final vesselViewModel = Provider.of<VesselViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vessel Registration',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFieldForms(
                  controller: _vesselNameController,
                  labelText: 'Vessel Name',
                ),
                const SizedBox(height: 10),
                CustomTextFieldForms(
                  controller: _placeController,
                  labelText: 'Location',
                ),
                const SizedBox(height: 10),
                CustomTextFieldForms(
                  controller: _portRegistryController,
                  labelText: 'Port Registry',
                ),
                const SizedBox(height: 10),
                CustomTextFieldForms(
                  controller: _ownerController,
                  labelText: 'Owner',
                ),
                const SizedBox(height: 10),
                CustomTextFieldForms(
                  controller: _operatorController,
                  labelText: 'Operator',
                ),
                const SizedBox(height: 10),
                CustomTextFieldForms(
                  controller: _imoController,
                  labelText: 'I.M.O',
                ),
                const SizedBox(height: 10),
                CustomFlagSelector(
                  initialValue: _selectedFlag,
                  onFlagSelected: (flag) {
                    setState(() {
                      _selectedFlag = flag;
                      _flagController.text = flag;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Save',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await vesselViewModel.addVessel(
                        _vesselNameController.text,
                        _placeController.text,
                        _portRegistryController.text,
                        _ownerController.text,
                        _selectedFlag,
                        _imoController.text,
                      );
                      if (mounted) {
                        _showSuccessMessage();
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}