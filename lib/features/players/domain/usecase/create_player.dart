import '../entities/player.dart';
import '../repository/players_repository.dart';

class CreatePlayer {
  final PlayersRepository repository;
  CreatePlayer(this.repository);

  Future<Player> call({
    required String nombre,
    required int edad,
    required String posicion,
    required String piernaAbil,
    required String equipo,
  }) async {
    return await repository.createPlayer(
      nombre: nombre,
      edad: edad,
      posicion: posicion,
      piernaAbil: piernaAbil,
      equipo: equipo,
    );
  }
}