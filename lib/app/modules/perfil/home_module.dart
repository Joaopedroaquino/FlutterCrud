import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/table_store.dart';
import 'views/drawer.dart';
import 'views/widgets/table_perfil.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => TableStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const DrawerPage(), children: [
      ChildRoute(
        '/perfil',
        child: (_, __) => MyHomePage(),
        transition: TransitionType.noTransition,
      ),
    ]),
  ];
}
