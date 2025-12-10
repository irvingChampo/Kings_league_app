import 'package:kings_league_app/core/error/exception.dart';
import 'package:kings_league_app/features/players/data/datasource/service_players.dart';
import 'package:kings_league_app/features/players/data/models/player_model.dart';
import 'package:kings_league_app/features/players/domain/entities/player.dart';
import 'package:kings_league_app/features/players/domain/repository/players_repository.dart';

// Implementación del repositorio. Actúa como un puente entre la capa de dominio y la de datos.
class PlayersRepositoryImpl extends PlayersRepository {
  final ServicePlayers servicePlayers;

  PlayersRepositoryImpl({required this.servicePlayers});

  @override
  Future<List<Player>> getPlayers() async {
    try {
      // El repositorio llama al datasource y devuelve los datos como entidades de dominio.
      return await servicePlayers.fetchPlayers();
    } on ServerException catch(e){
      throw ServerException(e.message);
    } on NetworkException catch(e){
      throw NetworkException(e.message);
    }
  }

  @override
  Future<Player> createPlayer({
    required String nombre,
    required int edad,
    required String posicion,
    required String piernaAbil,
    required String equipo,
  }) async {
    try {
      final playerModel = PlayerModel(
        id: '', // La API genera el ID
        nombre: nombre,
        edad: edad,
        posicion: posicion,
        piernaAbil: piernaAbil,
        equipo: equipo,
      );
      return await servicePlayers.createPlayer(playerModel);
    } on ServerException catch(e){
      throw ServerException(e.message);
    } on NetworkException catch(e){
      throw NetworkException(e.message);
    }
  }

  @override
  Future<void> deletePlayer(String id) async {
    try {
      return await servicePlayers.deletePlayer(id);
    } on ServerException catch(e){
      throw ServerException(e.message);
    } on NetworkException catch(e){
      throw NetworkException(e.message);
    }
  }
}