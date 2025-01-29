import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  final String descriptionText =
      'Aplikasi ini bernama "My Entertainment". Dalam aplikasi ini terdiri dari 3 bagian inti. Yaitu Movie, Anime, dan Music. Halaman Movie dan Anime menampilkan beberapa rekomendasi, sedangkan halaman Music bisa melakukan pencarian. Ketika salah satu item diklik akan membuka ke halaman Detail dari item tersebut.';
  final String creditText =
      "Sebagai disclaimer, aplikasi ini mengambil data dari public API, yaitu themoviedb.org untuk Movie, jikan.moe unutuk Anime, dan deezer.com untuk Music. Dan, karena mengambil data dari public API, aplikasi ini hanya untuk tujuan belajar dan tidak untuk diperjual-belikan.";
  final String linkText = """
  Movie :
  TMDB: https://www.themoviedb.org/
  Anime :
  JikanAPI: https://jikan.moe/
  Music :
  Deezer for dev: https://developers.deezer.com/
  """;

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // media query
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(12, 206, 240, 0.9),
          title: Text(
            "About",
            style: GoogleFonts.getFont("Aldrich",
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(238, 238, 238, 0.93))),
          ),
        ),
        body: SingleChildScrollView(
            child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Tentang "My Entertainment"',
                    style: GoogleFonts.getFont("Orbitron",
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0)),
                  ),
                ),
                const SizedBox(height: 16),
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Deskripsi : \n",
                          style: GoogleFonts.getFont("Lato",
                              textStyle: const TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.bold)),
                        ),
                        const WidgetSpan(
                            child: SizedBox(
                          height: 25.0,
                        )),
                        TextSpan(
                            text: descriptionText,
                            style: GoogleFonts.getFont("Lato",
                                textStyle: const TextStyle(fontSize: 17.0)))
                      ]),
                ),
                const SizedBox(height: 8),
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Disclaimer & Credit : \n",
                          style: GoogleFonts.getFont("Lato",
                              textStyle: const TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.bold)),
                        ),
                        const WidgetSpan(
                            child: SizedBox(
                          height: 25.0,
                        )),
                        TextSpan(
                            text: creditText,
                            style: GoogleFonts.getFont("Lato",
                                textStyle: const TextStyle(fontSize: 17.0)))
                      ]),
                ),
                const SizedBox(height: 16),
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Developer Team : \n",
                          style: GoogleFonts.getFont("Lato",
                              textStyle: const TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.bold)),
                        ),
                        const WidgetSpan(
                            child: SizedBox(
                          height: 25.0,
                        )),
                        TextSpan(
                            text: " - iierefaaen",
                            style: GoogleFonts.getFont("Lato",
                                textStyle: const TextStyle(fontSize: 17.0)))
                      ]),
                ),
                const SizedBox(height: 16),
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Contact us : \n",
                          style: GoogleFonts.getFont("Lato",
                              textStyle: const TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.bold)),
                        ),
                        const WidgetSpan(
                            child: SizedBox(
                          height: 25.0,
                        )),
                        TextSpan(
                            text:
                                " - fb : M Irfan\n - email : iierefaaen@gmail.com",
                            style: GoogleFonts.getFont("Lato",
                                textStyle: const TextStyle(fontSize: 17.0)))
                      ]),
                ),
                const SizedBox(height: 8),
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Link : \n",
                          style: GoogleFonts.getFont("Lato",
                              textStyle: const TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.bold)),
                        ),
                        const WidgetSpan(
                            child: SizedBox(
                          height: 25.0,
                        )),
                        TextSpan(
                            text: linkText,
                            style: GoogleFonts.getFont("Lato",
                                textStyle: const TextStyle(fontSize: 17.0)))
                      ]),
                ),
              ],
            ),
          ),
        )));
  }
}
