import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:my_entertainment/helper/helper.dart';

class MovieDetail extends StatefulWidget {
  final String movieId;

  const MovieDetail({super.key, required this.movieId});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  Map<String, dynamic>? movieData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMusicDetail(widget.movieId);
  }

  final String bearer =
      "YOUR_BEARER_KEY";

  Future<void> fetchMusicDetail(String id) async {
    final url =
        Uri.parse('https://api.themoviedb.org/3/movie/$id?language=en-US');
    try {
      final response =
          await http.get(url, headers: {"Authorization": "Bearer $bearer"});
      if (response.statusCode == 200) {
        setState(() {
          movieData = json.decode(response.body);
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
          // set color of back button ( flutter default <- )
          iconTheme: IconThemeData(
              color: const Color.fromRGBO(236, 240, 241, 0.95),
              size: screenWidth * 0.06),
          backgroundColor: const Color.fromRGBO(52, 73, 94, 0.95),
          title: Text(
            'Movie Detail',
            style: GoogleFonts.getFont("Tomorrow",
                textStyle: TextStyle(
                    color: const Color.fromRGBO(236, 240, 241, 0.95),
                    // font size : 5% of width device
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : movieData == null
                ? const Center(child: Text('Failed to load details.'))
                : SingleChildScrollView(
                    child: SizedBox(
                    width: screenWidth * 0.95,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500/${movieData!["poster_path"]}',
                              // height = 30 %
                              height: screenHeight * 0.3,
                              // width = 60 %
                              width: screenWidth * 0.6,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                              child: Text(
                            movieData!['original_title'],
                            style: GoogleFonts.getFont("Lexend Exa",
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.05,
                                )),
                          )),
                          const SizedBox(height: 8),
                          Text(
                            'Release: ${movieData!['release_date']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tagline: ${movieData!['tagline']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            textAlign: TextAlign.justify,
                            'Overview: ${movieData!["overview"]}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Genres : ${Helper.mapExtractor(movieData!["genres"], "name")}',
                            // 'Genres: ${Helper.joinListToString(movieData!["genres"], "name")}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '18+ rating: ${movieData!["adult"]}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Budget: ${Helper.formatCurrency(movieData!["budget"])}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Revenue : ${Helper.formatCurrency(movieData!["revenue"])}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Origin Country : ${Helper.listExtractor(movieData!["origin_country"])}',
                            // 'Original country: ${movieData!["origin_country"][0]}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Language : ${Helper.mapExtractor(movieData!["spoken_languages"], "english_name")}',
                            //'Language: ${movieData!["original_language"]}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Popularity: ${movieData!["popularity"].toString()}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Production Companies : ${Helper.mapExtractor(movieData!["production_companies"], "name")}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Production Countries : ${Helper.mapExtractor(movieData!["production_countries"], "name")}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Status : ${movieData!["status"]}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  )));
  }
}
