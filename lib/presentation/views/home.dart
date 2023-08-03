import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../blocs/blocs.dart';
import '../widgets/widgets.dart';
import 'new_todo.dart';

const textfieldKey = Key("textfieldKey");

/// App's home page.
/// The person will be able to create a new todo item
/// and view a list of previously created ones.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top navigation bar
      appBar: NavBar(
        givenContext: context,
      ),

      // Body of the page.
      // It is responsive and change style according to the device.
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          // If the list is loaded
          if (state is TodoListLoadedState) {
            final items = state.items;

            return SafeArea(
              child: Column(
                children: [
                  Container(
                    child: (() {
                      // On mobile
                      if (ResponsiveBreakpoints.of(context).isMobile) {
                        return TextField(
                          key: textfieldKey,
                          controller: TextEditingController(),
                          keyboardType: TextInputType.none,
                          onTap: () {
                            Navigator.of(context)
                                .push(navigateToNewTodoItemPage());
                          },
                          maxLines: 2,
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            hintText: 'Capture more things on your mind...',
                          ),
                          textAlignVertical: TextAlignVertical.top,
                        );
                      }

                      // On tablet and up
                      else {
                        return TextField(
                          key: textfieldKey,
                          controller: TextEditingController(),
                          keyboardType: TextInputType.none,
                          onTap: () {
                            Navigator.of(context)
                                .push(navigateToNewTodoItemPage());
                          },
                          maxLines: 2,
                          style: const TextStyle(fontSize: 30),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            hintText: 'Capture more things on your mind...',
                          ),
                          textAlignVertical: TextAlignVertical.top,
                        );
                      }
                    }()),
                  ),

                  // List of items
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(top: 40),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        if (items.isNotEmpty) const Divider(height: 0),
                        for (var i = 0; i < items.length; i++) ...[
                          if (i > 0) const Divider(height: 0),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ItemCard(item: items[i]),
                          )
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          // If the state of the TodoItemList is not loaded, we show error.ˆ
          else {
            return const Center(child: Text("Error loading items list."));
          }
        },
      ),
    );
  }
}
