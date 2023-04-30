
import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../repository/films_repository.dart';

class FilmSessions extends UseCase<List<FilmSessionModel>>{
  final FilmsRepository _filmsRepository;

  FilmSessions(this._filmsRepository);

  @override
  Future<Either<AppError, List<FilmSessionModel>>> call({String filmId=''}) async =>
    _filmsRepository.getFilmSessions(filmId);


}