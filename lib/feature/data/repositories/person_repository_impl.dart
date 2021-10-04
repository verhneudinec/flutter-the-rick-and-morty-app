import 'package:flutter/foundation.dart';
import 'package:flutter_rick_morty_app/core/error/exception.dart';
import 'package:flutter_rick_morty_app/core/platform/network_info.dart';
import 'package:flutter_rick_morty_app/feature/data/models/person_model.dart';
import 'package:flutter_rick_morty_app/feature/data/repositories/person_local_data_source.dart';
import 'package:flutter_rick_morty_app/feature/data/repositories/person_remote_data_source.dart';
import 'package:flutter_rick_morty_app/feature/domain/entities/person_entity.dart';
import 'package:flutter_rick_morty_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_rick_morty_app/feature/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() {
      return remoteDataSource.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() {
      return remoteDataSource.searchPerson(query);
    });
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePersons = await getPersons();
        localDataSource.personsToCache(remotePersons);
        return Right(remotePersons);
      } on ServerException {
        return Left(
          ServerFailure(),
        );
      }
    } else {
      try {
        final localPersons = await localDataSource.getLastPersonsFromCache();
        return Right(localPersons);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
