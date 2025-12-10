import 'package:flutter/material.dart';
import 'package:kings_league_app/features/players/domain/entities/player.dart';
import 'package:provider/provider.dart';
import '../providers/players_provider.dart';

class CardPlayer extends StatelessWidget {
  final Player player;

  const CardPlayer({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    player.nombre,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.amber
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red.shade300),
                  onPressed: () {
                    // Llama al método del provider para eliminar el jugador.
                    Provider.of<PlayersProvider>(context, listen: false)
                        .removePlayer(player.id);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(player.equipo, style: TextStyle(fontSize: 16, color: Colors.grey[400])),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoChip('Posición', player.posicion),
                _buildInfoChip('Edad', player.edad.toString()),
                _buildInfoChip('Pierna', player.piernaAbil),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}