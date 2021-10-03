import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rick_morty_app/core/error/exception.dart';
import 'package:flutter_rick_morty_app/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}

const CACHED_PERSONS_LIST = "CACHED_PERSONS_LIST";

/// TODO const file

class PersonDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST);

    if (jsonPersonsList.isNotEmpty) {
      return Future.value(
        jsonPersonsList
            .map(
              (person) => PersonModel.fromJson(
                json.decode(person),
              ),
            )
            .toList(),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList = persons
        .map(
          (person) => json.encode(
            person.toJson(),
          ),
        )
        .toList();

    // TODO 1?

    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);

    print('Persons write in Cache: ${jsonPersonsList.length}');

    return Future.value(jsonPersonsList);
  }
}
