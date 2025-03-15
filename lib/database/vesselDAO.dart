import 'databaseHelper.dart';
import '../models/vessel.dart';

class VesselDao {
  Future<int> insertVessel(Vessel vessel) async {
    final db = await DB.instance.database;
    return await db.insert('vessel', vessel.toMap());
  }

  Future<int> updateVessel(Vessel vessel) async {
    final db = await DB.instance.database;
    return await db.update(
      'vessel',
      vessel.toMap(),
      where: 'id = ?',
      whereArgs: [vessel.id],
    );
  }

  Future<int> deleteVessel(int id) async {
    final db = await DB.instance.database;
    return await db.delete(
      'vessel',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Vessel>> getAllVessels() async {
    final db = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('vessel');
    return List.generate(maps.length, (i) {
      return Vessel.fromMap(maps[i]);
    });
  }

  Future<Vessel?> getVesselById(int id) async {
    final db = await DB.instance.database;
    final List<Map<String, dynamic>> result = await db.query(
      'vessel',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? Vessel.fromMap(result.first) : null;
  }
}
