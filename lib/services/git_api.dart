import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubService {
  final String baseUrl = 'https://api.github.com/repos/';

  Future<List<dynamic>> fetchCommits(String owner, String repo) async {
    final response = await http.get(Uri.parse('$baseUrl$owner/$repo/commits'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load commits');
    }
  }
}
