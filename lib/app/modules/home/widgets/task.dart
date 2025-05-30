// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_list_provider/app/models/task_model.dart';

// import '../home_controller.dart';

// class Task extends StatefulWidget {
//   final TaskModel taskModel;

//   const Task({super.key, required this.taskModel});

//   @override
//   State<Task> createState() => _TaskState();
// }

// class _TaskState extends State<Task> {
//   final dateFormat = DateFormat('dd/MM/y');

//   void _removeTask(BuildContext context, {required TaskModel task}) {
//     showDialog(
//       context: context,
//       builder: (BuildContext ctx) {
//         return AlertDialog(
//           title: const Text('Excluir tarefa', style: TextStyle(fontWeight: FontWeight.bold)),
//           content: Text(
//             'Deseja excluir a tarefa (${task.description})?',
//             style: const TextStyle(fontSize: 16, height: 1.2),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 await context.read<ITaskService>().removeById(task.id);

//                 if (!mounted) return;

//                 context.read<HomeController>().refreshPage();

//                 Navigator.of(context).pop();
//               },
//               child: const Text('SIM', style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('NÃO', style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(width: 2, color: Colors.grey.shade300),
//       ),
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       child: IntrinsicHeight(
//         child: ListTile(
//           contentPadding: const EdgeInsets.only(top: 2, bottom: 8, left: 8, right: 8),
//           leading: Checkbox(
//             onChanged: (value) => context.read<HomeController>().checkOrUncheckTask(widget.taskModel),
//             value: widget.taskModel.done,
//           ),
//           title: Text(
//             widget.taskModel.description,
//             style: TextStyle(
//               height: 1.2,
//               decoration: widget.taskModel.done ? TextDecoration.lineThrough : null,
//             ),
//           ),
//           subtitle: Text(
//             dateFormat.format(widget.taskModel.dateTime),
//             style: TextStyle(decoration: widget.taskModel.done ? TextDecoration.lineThrough : null),
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//             side: const BorderSide(width: 2),
//           ),
//           trailing: IconButton(
//             onPressed: () => _removeTask(context, task: widget.taskModel),
//             icon: const Icon(Icons.delete_forever, color: Colors.red, size: 28),
//           ),
//         ),
//       ),
//     );
//   }
// }
