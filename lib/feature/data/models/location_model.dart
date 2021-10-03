import 'package:flutter/widgets.dart';
import 'package:flutter_rick_morty_app/feature/domain/entities/person_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    @required name,
    @required url,
  }) : super(
          name: name,
          url: url,
        );

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
