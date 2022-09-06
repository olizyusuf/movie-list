import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TopRated extends StatefulWidget {
  const TopRated({
    Key? key,
  }) : super(key: key);

  @override
  State<TopRated> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<TopRated> {
  @override
  Widget build(BuildContext context) {
    List data = [];
    // get api moviedb
    Future getNowPlaying() async {
      var token = '1d181ce46333081f5ea8a24060fc8120';
      var url = Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=$token&language=en-US&page=1');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var dataResponse = jsonDecode(response.body);
        data = dataResponse['results'];
      }
    }

    return FutureBuilder(
      future: getNowPlaying(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var movie = data[index];

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/movie-detail', arguments: {
                    'title': movie['title'],
                    'backdrop_path': movie['backdrop_path'],
                    'overview': movie['overview'],
                    'release_date': movie['release_date'],
                    'vote_average': movie['vote_average'],
                    'poster_path': movie['poster_path'],
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  padding: const EdgeInsets.all(10.0),
                  height: 250,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie['title'],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 160,
                            width: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${movie['poster_path']}'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sinopsis',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              SizedBox(
                                width: 230,
                                child: Text(
                                  movie['overview'].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 9,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        child: Row(children: [
                          const Text('Rating'),
                          const Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.red,
                          ),
                          Text(' : ${movie['vote_average']}/10')
                        ]),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
