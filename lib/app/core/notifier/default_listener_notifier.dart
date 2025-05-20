import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';

class DefaultListenerNotifier {
  DefaultListenerNotifier(this.defaultChangeNotifier);
  DefaultChangeNotifier defaultChangeNotifier;

  void listener({
    required BuildContext context,
    SuccessVoidCallback? onSuccess,
    ErrorVoidCallback? onError,
    EverVoidCallback? onEverCallback,
  }) {
    defaultChangeNotifier.addListener(() {
      onEverCallback?.call(defaultChangeNotifier, this);
      if (defaultChangeNotifier.loading) {
        context.loaderOverlay.show();
      } else {
        context.loaderOverlay.hide();
      }

      if (defaultChangeNotifier.hasError) {
        onError?.call(defaultChangeNotifier, this);
        Messages.of(context).showError(defaultChangeNotifier.error ?? 'Erro interno');
      } else if (defaultChangeNotifier.isSuccess) {
        onSuccess?.call(defaultChangeNotifier, this);
        Messages.of(context).showInfo('Sucesso');
      }
    });
  }
}

typedef SuccessVoidCallback =
    void Function(DefaultChangeNotifier notifier, DefaultListenerNotifier listenerNotifier);

typedef ErrorVoidCallback =
    void Function(DefaultChangeNotifier notifier, DefaultListenerNotifier listenerNotifier);

typedef EverVoidCallback =
    void Function(DefaultChangeNotifier notifier, DefaultListenerNotifier listenerNotifier);
