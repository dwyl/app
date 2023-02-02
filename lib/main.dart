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
          body: Column(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Capture what is on your mind...',
                      border: OutlineInputBorder()),
                  maxLines: null,
                  expands: true,
                ),
              ),
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
              CheckboxListTile(
                title: const Text('Item 3'),
                value: false,
                onChanged: (bool? v) {},
                controlAffinity: ListTileControlAffinity.leading,
              )
            ],
          )),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key});

  @override
  build(BuildContext context) {
    return const Center(child: Text('hello'));
  }
}
