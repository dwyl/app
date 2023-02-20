import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('DWYL'),
              centerTitle: true,
            ),
            body: const MyTextField()));
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
              decoration: const InputDecoration(
                  hintText: 'Capture what is on your mind..!.',
                  border: OutlineInputBorder()),
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
