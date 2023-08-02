import 'package:flutter/material.dart';

const backButtonKey = Key('backButtonKey');
const logoKey = Key('logoKey');

/// Navigation bar widget.
/// It needs to receive a context to dynamically elements.
class NavBar extends StatelessWidget implements PreferredSizeWidget {
  // Boolean that tells the bar to have a button to go to the previous page
  final bool showGoBackButton;
  // Build context for the "go back" button works
  final BuildContext givenContext;

  const NavBar({
    super.key,
    required this.givenContext,
    this.showGoBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(givenContext);
            },
            child:
                // dwyl logo
                Image.asset(
              "assets/icon/icon.png",
              key: logoKey,
              fit: BoxFit.fitHeight,
              height: 30,
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 81, 72, 72),
      elevation: 0.0,
      centerTitle: true,
      leading: showGoBackButton
          ? BackButton(
              key: backButtonKey,
              onPressed: () {
                Navigator.pop(givenContext);
              },
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
