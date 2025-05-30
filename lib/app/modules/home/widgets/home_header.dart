import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider_app.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Selector<AuthProviderApp, String>(
        selector: (context, authProvider) => authProvider.user?.displayName ?? 'Não informado',
        builder: (_, value, __) {
          return Text('E aí, $value!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
        },
      ),
    );
  }
}
