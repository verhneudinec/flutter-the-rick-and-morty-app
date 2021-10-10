import 'package:flutter/material.dart';
import 'package:flutter_rick_morty_app/feature/domain/entities/person_entity.dart';
import 'package:flutter_rick_morty_app/feature/presentation/pages/person_detail_screen.dart';
import 'package:flutter_rick_morty_app/feature/presentation/widgets/person_cache_image_widget.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity personResult;
  const SearchResult({Key key, this.personResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonDetailPage(person: personResult),
            ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Container(
                child: PersonCacheImage(
                  imageUrl: personResult.image,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personResult.name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personResult.location.name,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
