import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kings_league_app/core/error/exception.dart';
import 'package:kings_league_app/core/network/http_client.dart';
import '../models/player_model.dart';

// Contrato del DataSource.
abstract class ServicePlayers {
  Future<List<PlayerModel>> fetchPlayers();
  Future<PlayerModel> createPlayer(PlayerModel player);
  Future<void> deletePlayer(String id);
}

// Implementación concreta que usa el cliente HTTP para comunicarse con la API.
class ServicePlayersImpl implements ServicePlayers {
  final http.Client client;
  final apiUrl = dotenv.env['API_URL'];

  ServicePlayersImpl({http.Client? client})
      : client = client ?? HttpClient().client;

  @override
  Future<List<PlayerModel>> fetchPlayers() async {
    final url = Uri.parse('$apiUrl/players');
    try {
      final response = await client.get(url, headers: {
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        final List<dynamic> decoded = json.decode(response.body);
        return decoded.map((e) => PlayerModel.fromJson(e)).toList();
      } else {
        throw ServerException("Código: ${response.statusCode}");
      }
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  @override
  Future<PlayerModel> createPlayer(PlayerModel player) async {
    final url = Uri.parse('$apiUrl/players');
    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(player.toJson()),
      );
      if (response.statusCode == 201) {
        return PlayerModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException("Código: ${response.statusCode}");
      }
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  @override
  Future<void> deletePlayer(String id) async {
    final url = Uri.parse('$apiUrl/players/$id');
    try {
      final response = await client.delete(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) {
        throw ServerException("Código: ${response.statusCode}");
      }
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }
}