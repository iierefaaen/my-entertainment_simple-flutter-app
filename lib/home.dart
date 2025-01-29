import 'package:flutter/material.dart';
import 'package:my_entertainment/appbar.dart';
import 'package:my_entertainment/page_resources/anime_page.dart';
import 'package:my_entertainment/page_resources/movie_page.dart';
import 'package:my_entertainment/page_resources/music_page.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final int tabNumber = 3;

  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: tabNumber, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(187, 222, 251, 0.95),
      appBar: const AppBarWidget(),
      bottomNavigationBar: TabBar(
        labelStyle: GoogleFonts.getFont("Tomorrow",
            textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        labelColor: const Color.fromRGBO(33, 33, 33, 0.95),
        controller: _controller,
        indicatorColor: const Color.fromRGBO(245, 126, 71, 0.79),
        indicatorWeight: 6.0,
        tabs: const <Widget>[
          Tab(
            icon: Icon(
              Icons.ondemand_video,
              color: Color.fromRGBO(0, 0, 128, 0.95),
            ),
            height: 70.0,
            text: "Movie",
          ),
          Tab(
            icon: Icon(
              Icons.favorite_border_outlined,
              color: Color.fromRGBO(0, 0, 128, 0.95),
            ),
            height: 70.0,
            text: "Anime",
          ),
          Tab(
            icon: Icon(
              Icons.library_music_outlined,
              color: Color.fromRGBO(0, 0, 128, 0.95),
            ),
            height: 70.0,
            text: "Music",
          ),
        ],
      ),
      body: TabBarView(
        controller: _controller,
        children: const <Widget>[
          MoviePage(),
          AnimePage(),
          MusicPage(),
        ],
      ),
    );
  }
}
