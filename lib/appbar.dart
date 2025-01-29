import 'package:flutter/material.dart';
import 'package:my_entertainment/about/about.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double appbarHeight = 60.0;
  final String appbarTitle = "My Entertainment";

  const AppBarWidget({super.key});

  @override
  // Implements PreferredSizeWidget :
  Size get preferredSize => Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        appbarTitle,
        style: GoogleFonts.getFont("Orbitron",
            textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                color: const Color.fromRGBO(238, 238, 238, 0.95))),
      ),
      backgroundColor: const Color.fromRGBO(25, 118, 210, 0.95),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.info_outline_rounded),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AboutPage()));
          },
          color: const Color.fromRGBO(238, 238, 238, 0.95),
        )
      ],
    );
  }
}
