class TaskModel {
  final int id;
  final String description;
  final DateTime dateTime;
  final bool finished;

  TaskModel({required this.id, required this.description, required this.dateTime, required this.finished});

  factory TaskModel.loadFromDB(Map<String, dynamic> task) {
    return TaskModel(
      id: task['id'],
      description: task['description'],
      dateTime: DateTime.parse(task['created_at']),
      finished: task['is_finished'] == 1,
    );
  }

  TaskModel copyWith({int? id, String? description, DateTime? dateTime, bool? finished}) {
    return TaskModel(
      id: id ?? this.id,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      finished: finished ?? this.finished,
    );
  }
}
