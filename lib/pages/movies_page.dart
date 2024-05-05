import 'package:cinema_flutter/colors.dart';
import 'package:cinema_flutter/components/movie_tile.dart';
import 'package:cinema_flutter/services/database.dart';
import 'package:flutter/material.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.abc, color: Color.fromARGB(255, 22, 22, 22)),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle_rounded),
              onPressed: () {
                Navigator.of(context).pushNamed('profile');
              },
              iconSize: 30,
            )
          ],
          title: const Text("Catalogue"),
        ),
        drawer: const Icon(Icons.abc, color: Color.fromARGB(255, 22, 22, 22)),
        body: FutureBuilder(
          future: DBService.getMovies(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: accentColor),
                      const SizedBox(height: 20),
                      const Text("Loading data...")
                    ]),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 10),
                  child: MovieTile(snapshot.data![index]),
                )
              );
            }
          }));
  }
}
