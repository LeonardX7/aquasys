import 'package:flutter/material.dart';
import '../database/vesselDAO.dart';
import '../models/vessel.dart';

class VesselViewModel extends ChangeNotifier {
  final _vesselDao = VesselDao();
  List<Vessel> _vessels = [];
  
  List<Vessel> get vessels => _vessels;

  Future<void> loadVessels() async {
    _vessels = await _vesselDao.getAllVessels();
    notifyListeners();
  }

  Future<void> addVessel(String vesselName, String place, String portRegistry, String owner, String flag, String IMO, {String? imageUrl}) async {
    final vessel = Vessel(
      vesselName: vesselName,
      place: place,
      portRegistry: portRegistry,
      owner: owner,
      flag: flag,
      IMO: IMO,
      operator: owner,
      imageUrl: imageUrl,
    );
    await _vesselDao.insertVessel(vessel);
    await loadVessels();
  }

  Future<void> updateVessel(int id, String vesselName, String place, String portRegistry, String owner, String flag, String IMO, String operator, {String? imageUrl}) async {
    final vessel = Vessel(
      id: id,
      vesselName: vesselName,
      place: place,
      portRegistry: portRegistry,
      owner: owner,
      flag: flag,
      IMO: IMO,
      operator: operator,
      imageUrl: imageUrl,
    );
    await _vesselDao.updateVessel(vessel);
    await loadVessels();
  }

  Future<void> deleteVessel(int id) async {
    await _vesselDao.deleteVessel(id);
    await loadVessels();
  }

  Future<Vessel?> getVesselById(int id) async {
    return await _vesselDao.getVesselById(id);
  }
}
