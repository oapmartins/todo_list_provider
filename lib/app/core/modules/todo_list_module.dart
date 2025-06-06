import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_page.dart';

abstract class TodoListModule {
  final Map<String, WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings;

  TodoListModule({required Map<String, WidgetBuilder> routers, List<SingleChildWidget>? bindings})
    : _routers = routers,
      _bindings = bindings;

  Map<String, WidgetBuilder> get routers {
    return _routers.map(
      (key, value) => MapEntry(key, (_) {
        return TodoListPage(bindings: _bindings, routers: value);
      }),
    );
  }

  Widget getPage(String path, BuildContext context) {
    final widgetBuilder = _routers[path];
    if (widgetBuilder != null) {
      return TodoListPage(routers: widgetBuilder, bindings: _bindings);
    } else {
      throw Exception('Page not found: $path');
    }
  }
}
