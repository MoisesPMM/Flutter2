import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'ConnectionDb.dart';
import 'TaskRepository.dart';

Future<void> main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final repository = TaskRepository();
  

  final id = await repository.inserir({
    'task': 'Estudar Flutter',
    'done': 0,
    'created': DateTime.now().toIso8601String(),
  });

  print('Inserido com ID: $id');

  final tarefa = await repository.findById(id);
  print('Tarefa encontrada: $tarefa');

  await repository.atualizar({
    'id': id,
    'task': 'Estudar Flutter + SQLite',
    'done': 1,
    'created': DateTime.now().toIso8601String(),
  });

  print('Tarefa atualizada');

  final tarefas = await repository.listar();
  print('Lista de tarefas:');
  print(tarefas);

  await repository.deletar(id);
  print('Tarefa removida');

  await ConnectionDb.instance.close();
}