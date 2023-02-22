import 'package:flutter/material.dart';

import 'menu.dart';

const appBarKey = Key('appbar');
const textfieldKey = Key('textfield');
const saveButtonKey = Key('save_button');
const iconKey = Key('menu_icon_button');

// coverage:ignore-start
void main() {
  runApp(const MyApp());
}
// coverage:ignore-end

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'dwyl App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showMenu = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          key: appBarKey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icon/icon.png", fit: BoxFit.fitHeight, height: 30),
            ],
          ),
          leading: Container(),
          backgroundColor: Colors.black,
          elevation: 0.0,
          actions: [
            Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: showMenu,
              child: IconButton(
                key: iconKey,
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: const MyTextField(),
        endDrawer: SizedBox(width: MediaQuery.of(context).size.width * 1.0, child: const Drawer(child: DrawerMenu())));
  }
}

class MyTextField extends StatefulWidget {
  const MyTextField({super.key});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  int? _maxLines = 1;
  bool _expands = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Focus(
            onFocusChange: (focus) {
              focus ? extendsFieldText() : minimizeFieldText();
            },
            child: TextField(
              key: textfieldKey,
              decoration: const InputDecoration(hintText: 'Capture what is on your mind..!.', border: OutlineInputBorder()),
              expands: _expands,
              maxLines: _maxLines,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
            ),
          ),
        ),
        if (_expands)
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
                key: saveButtonKey,
                onPressed: () {
                  minimizeFieldText();
                },
                child: const Text('Save')),
          ),
        //if (!_expands) const MyItems()
      ],
    );
  }

  void extendsFieldText() {
    setState(() {
      _expands = true;
      _maxLines = null;
    });
  }

  void minimizeFieldText() {
    setState(() {
      _expands = false;
      _maxLines = 1;
    });
  }
}

class MyItems extends StatelessWidget {
  const MyItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          CheckboxListTile(
            title: const Text('Item 1'),
            value: false,
            onChanged: (bool? v) {},
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: const Text('Item 2'),
            value: false,
            onChanged: (bool? v) {},
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ],
      ),
    );
  }
}
