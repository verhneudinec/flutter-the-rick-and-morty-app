import 'package:flutter/material.dart';
import 'package:flutter_rick_morty_app/common/app_colors.dart';
import 'package:flutter_rick_morty_app/feature/domain/entities/person_entity.dart';
import 'package:flutter_rick_morty_app/feature/presentation/widgets/person_cache_image_widget.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;

  const PersonDetailPage({Key key, @required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Character"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 24.0,
            ),
            Text(
              person.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              child: PersonCacheImage(
                width: 260,
                height: 260,
                imageUrl: person.image,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: person.status == 'Alive' ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  person.status,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
            if (person.type.isNotEmpty)
              ..._buildText(title: 'Type', text: person.type),
            ..._buildText(title: "Gender", text: person.gender),
            ..._buildText(
              title: "Number of episodes",
              text: person.episode.length.toString(),
            ),
            ..._buildText(
              title: "Species",
              text: person.species,
            ),
            ..._buildText(
              title: "Last known location",
              text: person.location.name,
            ),
            ..._buildText(
              title: "Origin",
              text: person.origin.name,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildText({String title, String text}) {
    return [
      const SizedBox(
        height: 16.0,
      ),
      Text(
        title,
        style: TextStyle(
          color: AppColors.greyColor,
          fontSize: 16,
        ),
        maxLines: 1,
      ),
      const SizedBox(
        height: 4.0,
      ),
      Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        maxLines: 1,
      ),
    ];
  }
}
