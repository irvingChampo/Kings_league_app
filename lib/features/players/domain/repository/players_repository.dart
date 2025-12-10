import '../entities/player.dart';

// Contrato que define las operaciones que se pueden realizar con los jugadores.
// La capa de dominio no sabe CÓMO se obtienen los datos, solo QUÉ se puede hacer.
abstract class PlayersRepository {
  Future<List<Player>> getPlayers();

  Future<Player> createPlayer({
    required String nombre,
    required int edad,
    required String posicion,
    required String piernaAbil,
    required String equipo,
  });

  Future<void> deletePlayer(String id);
}