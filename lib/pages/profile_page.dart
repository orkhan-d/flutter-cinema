import 'package:cinema_flutter/colors.dart';
import 'package:cinema_flutter/components/button.dart';
import 'package:cinema_flutter/components/movie_tile.dart';
import 'package:cinema_flutter/services/auth.dart';
import 'package:cinema_flutter/services/database.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<dynamic> showLikedMovies(BuildContext context) async {
    List<Map<String, dynamic>> likedMovies = await DBService.getLikedMovies();

    return showModalBottomSheet(
      useRootNavigator: false,
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          builder:(context, scrollController) => Expanded(
            child: ListView.builder(
              itemCount: likedMovies.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 10
                ),
                child: MovieTile(likedMovies[index]),
              )
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBService.getUser(AuthService.me()!.uid),
      builder:(context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Profile"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Center(
                        child: Icon(
                          Icons.account_circle_rounded,
                          size: 200,
                        )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Full name: ", style: profileInfoCaption),
                          Text(snapshot.data!['fullname'], style: profileInfoText),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Login: ", style: profileInfoCaption),
                          Text(snapshot.data!['login'], style: profileInfoText),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("E-mail: ", style: profileInfoCaption),
                          Text(snapshot.data!['email'], style: profileInfoText),
                        ],
                      )
                    ]
                  ),
                  Column(
                    children: [
                      Button("Favourites", () => showLikedMovies(context)),
                      const SizedBox(height: 20),
                      Button("Edit", () => Navigator.of(context).pushReplacementNamed('profile_edit')),
                      const SizedBox(height: 20),
                      Button("Logout", () async {
                        await AuthService.logout();
                        Navigator.of(context).pushReplacementNamed('login');
                      }),
                      const SizedBox(height: 30),
                    ],
                  )
                ]
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Profile"),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(color: accentColor)
                )
              ],
            ),
          );
        }
      }
    );
  }
}