import 'dart:ui';
import 'package:beamer/beamer.dart';
import 'package:cine_me/core/constants/font_styling.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/presentation/widgets/transparent_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

BoxDecoration imageBackgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.black.withOpacity(0.9),
      Colors.black.withOpacity(0.3),
      Colors.black.withOpacity(0.9),
    ],
  ),
);

class FilmDetailsWidget extends StatelessWidget {
  final List<FilmModel> films;
  final String detailsPath;
  final YoutubePlayerController controller;
  const FilmDetailsWidget({Key? key,
    required this.films,
    required this.detailsPath,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(films[0].image),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
              decoration: imageBackgroundDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: YoutubePlayer(
                      controller: controller,
                      showVideoProgressIndicator: true,
                    )),
                    Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                      Text(films[0].name, style: notoSansDisplayBoldLarge,),
                      const SizedBox(width: 10,),
                      Text(films[0].year.toString(), style: notoSansDisplayBoldLarge)
                    ]),
                    Padding(padding: EdgeInsets.only(left: 10, right: 10),child:
                    Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                Text(films[0].genre, style: notoSansDisplayRegularTiny),
                const SizedBox(width: 5,),
                Text(films[0].country, style: notoSansDisplayRegularTiny),
                 Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       for (var i = 0; i < double.parse(films[0].rating).toInt(); i++)
                        const Icon(Icons.star, color: CupertinoColors.systemYellow,),
                  Text(films[0].rating, style: notoSansDisplayRegularTiny),
                    ])])),
                Padding(padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(films[0].starring, style: notoSansDisplayRegularSmall)),
                Padding(padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(films[0].plot, style: notoSansDisplayRegularTiny)),
                Padding(padding: const EdgeInsets.only(left: 20, right: 20),
                child:CustomButton(
                    onPressed: () {
                      Beamer.of(context).beamToNamed(
                          '$detailsPath?filmId=${films[0].id}');
                    },
                    text: 'Переглянути сеанси'))
              ])),
        ));
  }
}