import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rick_morty_app/core/error/failure.dart';
import 'package:flutter_rick_morty_app/core/usecases/usecase.dart';
import 'package:flutter_rick_morty_app/feature/domain/entities/person_entity.dart';
import 'package:flutter_rick_morty_app/feature/domain/repositories/person_repository.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  final PersonRepository personRepository;

  GetAllPersons(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(
      PagePersonParams params) async {
    return await personRepository.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;

  PagePersonParams({@required this.page});

  @override
  List<Object> get props => [page];
}
