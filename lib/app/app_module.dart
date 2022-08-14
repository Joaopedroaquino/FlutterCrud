import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/perfil/home_module.dart';
import 'splash_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: ((context, args) => const SplashPage())),
    ModuleRoute('/dashboard', module: HomeModule()),
    WildcardRoute(
        child: (_, __) => const Scaffold(
              body: Center(
                  child: Card(
                child: Text("404"),
              )),
            )),
  ];
}
