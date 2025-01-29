import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:my_entertainment/detail_page/anime_detail.dart';
import 'dart:convert';

import 'package:my_entertainment/helper/helper.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key});

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  final String apiEndpoint = "https://api.jikan.moe/v4/recommendations/anime";

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiEndpoint));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // media query
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double fontSizeHeader = screenWidth * 0.05;
    final double fontSizeOverview = screenWidth * 0.04;

    final double cardHeight = screenHeight * 0.45;
    final double cardWidth = screenWidth * 0.45;

    return Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return SizedBox(
                  // height: 490.0,
                  child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.45,
                ),
                itemCount: snapshot.data!["data"].length,
                itemBuilder: (context, index) {
                  var item = snapshot.data!["data"][index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AnimeDetail(
                                animeId:
                                    item["entry"][0]["mal_id"].toString())));
                      },
                      child: Container(
                        height: cardHeight,
                        width: cardWidth,
                        margin: const EdgeInsets.only(top: 5.0),
                        child: Card(
                          color: const Color.fromRGBO(245, 245, 245, 0.95),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0, top: 5.0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7.0)),
                                  child: Image.network(
                                    item['entry'][0]["images"]["jpg"]
                                        ['image_url'],
                                    fit: BoxFit.cover,
                                    repeat: ImageRepeat.noRepeat,
                                    height: cardHeight * 0.71,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  Helper.truncateText(
                                      item['entry'][0]["title"], 7),
                                  style: GoogleFonts.getFont("Roboto",
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: fontSizeHeader,
                                          color: const Color.fromRGBO(
                                              33, 33, 33, 0.95))),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    Helper.truncateText(item["content"], 10),
                                    style: GoogleFonts.getFont("Roboto",
                                        textStyle: TextStyle(
                                            fontSize: fontSizeOverview,
                                            color: const Color.fromRGBO(
                                                33, 33, 33, 0.95))),
                                  ))
                            ],
                          ),
                        ),
                      ));
                },
              ));
            } else {
              return const Center(child: Text('No data found'));
            }
          },
        ));
  }
}
