import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key, List<SingleChildWidget>? bindings, required WidgetBuilder routers})
    : _bindings = bindings,
      page = routers;

  final List<SingleChildWidget>? _bindings;
  final WidgetBuilder page;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _bindings ?? [Provider(create: (_) => Object())],
      child: Builder(builder: (context) => page(context)),
    );
  }
}
