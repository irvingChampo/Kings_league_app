import '../repository/players_repository.dart';
class DeletePlayer {
  final PlayersRepository repository;
  DeletePlayer(this.repository);
  Future<void> call(String id) async {
    return await repository.deletePlayer(id);
  }
}