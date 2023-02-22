import 'package:flutter/material.dart';

const drawerMenuKey = Key("drawer_menu");
const todoTileKey = Key("todo_tile");
const tourTileKey = Key("tour_tile");
const settingsTileKey = Key("settings_tile");

const closeMenuKey = Key("close_key_icon");

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerMenuKey,
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/icon/icon.png", fit: BoxFit.fitHeight, height: 30),
          ),
          actions: [
            IconButton(
              key: closeMenuKey,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.menu_open,
                color: Colors.white,
              ),
            ),
          ]),
      body: Container(
          color: Colors.black,
          child: ListView(key: todoTileKey, padding: const EdgeInsets.only(top: 32), children: [
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white), top: BorderSide(color: Colors.white))),
              child: const ListTile(
                leading: Icon(
                  Icons.check_outlined,
                  color: Colors.white,
                  size: 50,
                ),
                title: Text('Todo List (Personal)',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
              child: const ListTile(
                key: tourTileKey,
                leading: Icon(
                  Icons.flag_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                title: Text('Feature Tour',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
              child: const ListTile(
                key: settingsTileKey,
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 40,
                ),
                title: Text('Settings',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    )),
              ),
            ),
          ])),
    );
  }
}