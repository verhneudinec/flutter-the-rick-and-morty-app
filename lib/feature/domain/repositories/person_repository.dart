import 'package:flutter_rick_morty_app/core/error/failure.dart';
import 'package:flutter_rick_morty_app/feature/domain/entities/person_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);

  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
