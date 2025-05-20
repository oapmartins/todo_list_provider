// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider_app.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/services/user_service.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});

  final nameVN = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: context.primaryColor.withAlpha(70)),

            child: Row(
              children: [
                Selector<AuthProviderApp, String>(
                  selector: (context, authProviderApp) {
                    return authProviderApp.user?.photoURL ?? '';
                  },
                  builder: (_, value, __) {
                    if (value.isEmpty) {
                      return const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, size: 30, color: Colors.white),
                      );
                    }
                    return CircleAvatar(radius: 30, backgroundImage: NetworkImage(value));
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProviderApp, String>(
                      selector: (context, authProviderApp) {
                        return authProviderApp.user?.displayName ?? 'Não informado';
                      },
                      builder: (_, value, __) {
                        return Text(
                          value,
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Alterar nome'),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Alterar nome'),
                    content: TextField(
                      decoration: const InputDecoration(labelText: 'Nome'),
                      onChanged: (value) => nameVN.value = value,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          if (nameVN.value.isEmpty) {
                            return Messages.of(context).showError('Nome obrigatório');
                          }

                          await context.read<UserService>().updateName(nameVN.value);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Salvar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {
              context.read<AuthProviderApp>().logout();
            },
          ),
        ],
      ),
    );
  }
}
