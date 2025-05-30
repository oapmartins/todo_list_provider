import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key, this.bindings, required this.routers});

  final List<SingleChildWidget>? bindings;
  final WidgetBuilder routers;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: bindings ?? [Provider(create: (_) => Object())],
      child: Builder(builder: (context) => routers(context)),
    );
  }
}
