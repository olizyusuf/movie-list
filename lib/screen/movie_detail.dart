import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined,
              size: 40.0, color: Colors.amber[800]),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.amber[800],
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w500${data['backdrop_path']}',
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.cover,
                    color: const Color.fromRGBO(255, 255, 255, 0.4),
                    colorBlendMode: BlendMode.modulate,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 60),
                    height: 250,
                    width: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${data['poster_path']}'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                data['title'],
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(data['release_date']),
              const Divider(
                thickness: 1,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  data['overview'],
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Rating : ${data['vote_average'].toString()}/10',
                style: TextStyle(
                  color: Colors.amber[800],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
    );
  }
}
