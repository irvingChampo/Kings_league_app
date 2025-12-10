import '../entities/player.dart';
import '../repository/players_repository.dart';

// Caso de uso específico para obtener la lista de jugadores.
class GetPlayers {
  final PlayersRepository playersRepository;

  GetPlayers(this.playersRepository);

  // El método 'call' permite que la clase sea invocada como una función.
  Future<List<Player>> call() async {
    return await playersRepository.getPlayers();
  }
}