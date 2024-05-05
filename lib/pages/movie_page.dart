import 'package:cinema_flutter/colors.dart';
import 'package:cinema_flutter/components/button.dart';
import 'package:cinema_flutter/components/input.dart';
import 'package:cinema_flutter/services/database.dart';
import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget {
  final Map<String, dynamic> movieData;

  const MoviePage(
    this.movieData,
    {super.key}
  );

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late Map<String, dynamic>? movieData;
  late int rating;
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    movieData = widget.movieData;
    rating = widget.movieData['rating'];
    messageController.text = widget.movieData['message'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            onPressed: () {
              Navigator.of(context).pushNamed('profile');
            },
            iconSize: 30,
          )
        ],
        title: Text(
          movieData!['title'],
          overflow: TextOverflow.fade,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Image.network(
                    movieData!['image_url'],
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
                    height: MediaQuery.of(context).size.width*0.3*5/3,
                    width: MediaQuery.of(context).size.width*0.60,
                    child: Text(
                      movieData!['description'],
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ]
              ),
              const SizedBox(height: 10),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    color: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(15))
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      size: 50,
                    )
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Text(
                "Already watched? Rate it!",
                style: profileInfoText,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [1,2,3,4,5].map((e) {
                  return IconButton(
                    onPressed: () {
                      rating = e;
                      setState(() {});
                    },
                    icon: Icon(
                      rating>=e
                      ? Icons.star_outlined
                      : Icons.star_border_outlined,
                      size: 40,
                      color: Colors.amber.shade400,
                    )
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              Input(messageController, placeholder: "How did you like this movie?", maxLines: null),
              const SizedBox(height: 15),
              Button("Submit", () {
                movieData!['rating'] = rating;
                movieData!['message'] = messageController.text;
                DBService.setRating(
                  movieData!['id'],
                  messageController.text,
                  rating
                );
                setState(() {});
              })
            ],
          ),
        ),
      )
    );
  }
}