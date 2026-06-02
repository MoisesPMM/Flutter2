import 'package:flutter/material.dart';
import 'TaskRepository.dart';
import 'Task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final repository = TaskRepository();
  final TextEditingController controller = TextEditingController();

  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final data = await repository.listar();
    setState(() {
      tasks = data;
    });
  }

  Future<void> addTask() async {
    if (controller.text.isEmpty) return;

    await repository.inserir(
      Task(
        task: controller.text,
        done: false,
        created: DateTime.now(),
      ),
    );

    controller.clear();
    loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await repository.deletar(id);
    loadTasks();
  }

  Future<void> toggleTask(Task task) async {
    await repository.atualizar(
      Task(
        id: task.id,
        task: task.task,
        done: !task.done,
        created: task.created,
      ),
    );

    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Nova tarefa...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addTask,
                  child: const Icon(Icons.add),
                )
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return ListTile(
                  leading: Checkbox(
                    value: task.done,
                    onChanged: (_) => toggleTask(task),
                  ),
                  title: Text(
                    task.task,
                    style: TextStyle(
                      decoration: task.done
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteTask(task.id!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}