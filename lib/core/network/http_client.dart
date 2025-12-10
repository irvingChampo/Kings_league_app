import 'package:http/http.dart' as http;

// Clase Singleton para gestionar una única instancia del cliente HTTP en toda la app.
class HttpClient {
  // Instancia privada y estática.
  static final HttpClient _instance = HttpClient._internal();
  late final http.Client client;

  // Factory constructor que devuelve siempre la misma instancia.
  factory HttpClient() {
    return _instance;
  }

  // Constructor privado.
  HttpClient._internal() {
    client = http.Client();
  }

  // Método para cerrar el cliente cuando ya no se necesite.
  void dispose() {
    client.close();
  }
}