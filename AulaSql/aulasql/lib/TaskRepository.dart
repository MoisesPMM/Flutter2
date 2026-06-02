import 'ConnectionDb.dart';
import 'Task.dart';

class TaskRepository {
  final ConnectionDb _connectionDb = ConnectionDb.instance;

  Future<int> inserir(Task task) async {
    final db = await _connectionDb.database;

    return await db.insert(
      'tasks',
      task.toMap(),
    );
  }

  Future<int> atualizar(Task task) async {
    final db = await _connectionDb.database;

    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
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

  Future<Task?> findById(int id) async {
    final db = await _connectionDb.database;

    final result = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return Task.fromMap(result.first);
  }

  Future<List<Task>> listar() async {
    final db = await _connectionDb.database;

    final result = await db.query('tasks');

    return result.map((e) => Task.fromMap(e)).toList();
  }
}