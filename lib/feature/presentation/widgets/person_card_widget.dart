import 'package:flutter/material.dart';
import 'package:flutter_rick_morty_app/common/app_colors.dart';
import 'package:flutter_rick_morty_app/feature/domain/entities/person_entity.dart';
import 'package:flutter_rick_morty_app/feature/presentation/pages/person_detail_screen.dart';
import 'package:flutter_rick_morty_app/feature/presentation/widgets/person_cache_image_widget.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;

  const PersonCard({
    Key key,
    this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PersonDetailPage(person: person),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cellBackground,
            ),
            child: Row(
              children: [
                Container(
                  child: PersonCacheImage(
                    imageUrl: person.image,
                    width: 170,
                    height: 170,
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        person.name,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 16.0,
                            width: 16.0,
                            decoration: BoxDecoration(
                              color: person.status == 'Alive'
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Text(
                              '${person.status} - ${person.species}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        'Last known location: ',
                        style: TextStyle(color: AppColors.greyColor),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        person.location.name,
                        style: TextStyle(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        'Origin: ',
                        style: TextStyle(color: AppColors.greyColor),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        person.origin.name,
                        style: TextStyle(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
