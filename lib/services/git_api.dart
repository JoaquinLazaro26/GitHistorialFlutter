import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubService {
  final String baseUrl = 'https://api.github.com';

  Future<List<dynamic>> fetchCommits(String owner, String repo) async {
    final url = Uri.parse('$baseUrl/repos/$owner/$repo/commits');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los commits');
    }
  }

  Future<List<dynamic>> fetchRepositories(String owner) async {
    final url = Uri.parse('$baseUrl/users/$owner/repos');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los repositorios');
    }
  }
}
