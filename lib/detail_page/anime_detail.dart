import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:my_entertainment/helper/helper.dart';

class AnimeDetail extends StatefulWidget {
  final String animeId;

  const AnimeDetail({super.key, required this.animeId});

  @override
  State<AnimeDetail> createState() => _AnimeDetailState();
}

class _AnimeDetailState extends State<AnimeDetail> {
  Map<String, dynamic>? trackData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMusicDetail(widget.animeId);
  }

  Future<void> fetchMusicDetail(String id) async {
    final url = Uri.parse("https://api.jikan.moe/v4/anime/$id/full");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          trackData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load track details');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      throw Exception('Error fetching track details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // media query
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double fontSizeBig = screenWidth * 0.05;
    final double fontSizeSmall = screenWidth * 0.04;
    final double sizedBoxSize = screenHeight * 0.01;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(52, 73, 94, 0.95),
          // set color of back button ( flutter default <- )
          iconTheme: IconThemeData(
              color: const Color.fromRGBO(236, 240, 241, 0.95),
              size: screenWidth * 0.06),
          title: Text(
            'Anime Detail',
            style: GoogleFonts.getFont("Tomorrow",
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(236, 240, 241, 0.95),
                    fontSize: fontSizeBig)),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : trackData == null
                ? const Center(child: Text('Failed to load details.'))
                : SizedBox(
                    width: screenWidth,
                    height: screenHeight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.network(
                                trackData?["data"]?["images"]?["jpg"]
                                        ?["image_url"] ??
                                    "No image available",
                                // height = 30 %
                                height: screenHeight * 0.3,
                                // width = 60 %
                                width: screenWidth * 0.6,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Center(
                                child: Text(
                              trackData?["data"]?['title_japanese'] ??
                                  "No title japanese available",
                              style: TextStyle(
                                fontSize: fontSizeBig,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            SizedBox(height: sizedBoxSize),
                            Center(
                                child: Text(
                              textAlign: TextAlign.center,
                              trackData?["data"]?['title'] ??
                                  "No data title available",
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            SizedBox(height: sizedBoxSize),
                            Center(
                                child: Text(
                              trackData?["data"]?['title_english'] ??
                                  "No title english available",
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            SizedBox(height: sizedBoxSize),
                            Center(
                                child: Text(
                              trackData?["data"]?['year'].toString() ??
                                  "No data year release",
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Duration: ${trackData?["data"]?['duration'] ?? "No data available"}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Producers: ${Helper.mapExtractor(trackData!["data"]['producers'], "name")}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Licensors: ${Helper.mapExtractor(trackData!["data"]['licensors'], "name")}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Studios: ${Helper.mapExtractor(trackData!["data"]['studios'], "name")}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Genres: ${Helper.mapExtractor(trackData!["data"]['genres'], "name")}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Themes: ${Helper.mapExtractor(trackData!["data"]['themes'], "name")}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Rating: ${trackData?["data"]?['rating'] ?? "No data available"}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              textAlign: TextAlign.justify,
                              'Synopsis: ${trackData?["data"]?['synopsis'] ?? "No data available"}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Broadcast: ${trackData?["data"]?["broadcast"]?["string"] ?? "No data available"} ${trackData?["data"]?["broadcast"]?["timezone"] ?? "No data available"} local time',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Trailer: ${trackData?["data"]?["trailer"]?["url"] ?? "No data available"}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Type: ${trackData?["data"]?["type"] ?? "No data available"}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Source: ${trackData?["data"]?["source"] ?? "No data available"}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Episodes: ${trackData?["data"]?["episodes"].toString() ?? "No data available"}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Status: ${trackData?["data"]?["status"] ?? "No data available"}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Aired: from ${trackData?["data"]?["aired"]?["string"] ?? "No data available"}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Openings: ${Helper.listExtractor(trackData!["data"]['theme']["openings"])}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Endings: ${Helper.listExtractor(trackData!["data"]['theme']["endings"])}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'External link: ${Helper.mapExtractor(trackData!["data"]['external'], "url")}}}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                            Text(
                              'Streaming links: ${Helper.mapExtractor(trackData!["data"]['streaming'], "url")}',
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                            SizedBox(height: sizedBoxSize),
                          ],
                        ),
                      ),
                    )));
  }
}
