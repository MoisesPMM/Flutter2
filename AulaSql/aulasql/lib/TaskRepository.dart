


import 'ConnectionDb.dart';

class TaskRepository {

  final ConnectionDb _connectionDb = ConnectionDb.instance;

  Future<int> inserir(Map<String, dynamic> task) async{
    final db = await _connectionDb.database;

      return await db.insert(
          'tasks',
          task,

      );
  }

   Future<int> atualizar(Map<String, dynamic> task) async {
    final db = await _connectionDb.database;

    return await db.update(
      'tasks',
      task,
      where: 'id = ?',
      whereArgs: [task['id']],
    );
  }

  Future<int> deletar(int id) async {
    final db = await _connectionDb.database;

    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, dynamic>?> findById(int id) async {
    final db = await _connectionDb.database;

    final result = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  Future<List<Map<String, dynamic>>> listar() async {
    final db = await _connectionDb.database;

    return await db.query('tasks');
  }

}