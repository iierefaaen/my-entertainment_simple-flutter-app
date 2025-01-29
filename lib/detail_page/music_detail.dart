import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class MusicDetail extends StatefulWidget {
  final String musicId;

  const MusicDetail({super.key, required this.musicId});

  @override
  State<MusicDetail> createState() => _MusicDetailState();
}

class _MusicDetailState extends State<MusicDetail> {
  Map<String, dynamic>? trackData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMusicDetail(widget.musicId);
  }

  Future<void> fetchMusicDetail(String id) async {
    final url = Uri.parse('https://api.deezer.com/track/$id');
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(52, 73, 94, 0.95),
          iconTheme: IconThemeData(
            color: const Color.fromRGBO(236, 240, 241, 0.95),
            size: screenWidth * 0.06,
          ),
          title: Text(
            'Music Detail',
            style: GoogleFonts.getFont("Tomorrow",
                textStyle: TextStyle(
                    color: const Color.fromRGBO(236, 240, 241, 0.95),
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05)),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.network(
                              trackData!['album']['cover_xl'],
                              height: screenHeight * 0.3,
                              width: screenWidth * 0.6,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            trackData!['title'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Artist: ${trackData!['artist']['name']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Album: ${trackData!['album']['title']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Release: ${trackData!['release_date']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Link: ${trackData!['link']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Duration: ${(trackData!['duration'] ~/ 60)}:${(trackData!['duration'] % 60).toString().padLeft(2, '0')} minutes',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ));
  }
}
