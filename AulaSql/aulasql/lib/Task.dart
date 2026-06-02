class Task {
  final int? id;
  final String task;
  final bool done;
  final DateTime created;

  Task({
    this.id,
    required this.task,
    required this.done,
    required this.created,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'task': task,
      'done': done ? 1 : 0,
      'created': created.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      task: map['task'],
      done: map['done'] == 1,
      created: DateTime.parse(map['created']),
    );
  }
}