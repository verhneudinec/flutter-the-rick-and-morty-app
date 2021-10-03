import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rick_morty_app/core/error/exception.dart';
import 'package:flutter_rick_morty_app/feature/data/models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemoteDataSource {
  /// Calls the https://rickandmortyapi.com/api/character?page=2 endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<PersonModel>> getAllPersons(int page) {}

  /// Calls the https://rickandmortyapi.com/api/character?name=Rick
  Future<List<PersonModel>> searchPerson(String query) {}
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<PersonModel>> getAllPersons(int page) =>
      _getPersonFromUrl("https://rickandmortyapi.com/api/character?page=$page");

  @override
  Future<List<PersonModel>> searchPerson(String query) => _getPersonFromUrl(
      "https://rickandmortyapi.com/api/character?name=$query");

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    print(url);

    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final persons = json.decode(response.body);

      return (persons['results'] as List)
          .map(
            (person) => PersonModel.fromJson(person),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }
}
