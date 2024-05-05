import 'dart:math';

import 'package:cinema_flutter/colors.dart';
import 'package:cinema_flutter/pages/movie_page.dart';
import 'package:cinema_flutter/services/database.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatefulWidget {
  final Map<String, dynamic> movieData;
  const MovieTile(
    this.movieData,
    {super.key}
  );

  @override
  State<MovieTile> createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  late Map<String, dynamic> movieData;

  @override
  void initState() {
    super.initState();
    movieData = widget.movieData;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder:(context) => MoviePage(movieData))),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: accentColor)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Image.network(
              movieData['image_url'],
              width: MediaQuery.of(context).size.width*0.3,
              height: MediaQuery.of(context).size.width*0.3*5/3,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                   return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                }
              },
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.02),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    movieData['title'],
                    style: movieTileTitle,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    movieData['description'],
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${max(0, movieData['avgRating'] as double)}/5",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.yellow.shade500,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade500,
                            size: 25,
                          )
                        ],
                      ),
                      IconButton(
                        onPressed: () async {
                          await DBService.toggleMovieLike(movieData['id']);
                          movieData['liked'] = !movieData['liked'];
                          setState(() {});
                        },
                        icon: (
                          movieData['liked']
                          ? const Icon(
                            Icons.bookmark_rounded,
                            color: Colors.red,
                          )
                          : const Icon(
                            Icons.bookmark_outline_rounded,
                            color: Colors.red,
                          )
                        )
                      )
                    ]
                  )
                ],
              )
            )
          ]
        ),
      ),
    );
  }
}