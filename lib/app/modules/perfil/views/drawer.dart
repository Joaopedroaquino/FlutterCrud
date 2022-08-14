import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD'),
        elevation: 20,
        titleSpacing: 10.1,
        bottomOpacity: 90,
        toolbarHeight: 50,
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [ElevatedButton(onPressed: () {}, child: Icon(Icons.search))],
      ),
      body: Row(
        children: [
          Drawer(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 179, 25, 25),
                    Color.fromARGB(255, 192, 24, 24),
                    Color.fromARGB(255, 255, 0, 0),
                  ],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          // child: Icon(
                          //   Icons.playlist_add_check_circle_outlined,
                          //   color: Colors.white,
                          //   size: 40,
                          // ),
                        ),
                        Text(
                          'CRUD',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: 12),
                    ),
                  ),
                  ListTile(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    leading: const Icon(Icons.featured_play_list_outlined),
                    title: const Text('Dashboard'),
                    onTap: () {
                      Modular.to.navigate('./perfil');
                    },
                  ),
                ],
              ),
            ),
          ),
          const Expanded(child: RouterOutlet()),
        ],
      ),
    );
  }
}
