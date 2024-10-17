import 'package:flutter/material.dart';
import '../services/git_api.dart';

class CommitsGitScreen extends StatefulWidget {
  const CommitsGitScreen({super.key});
  @override
  CommitsGitScreenState createState() => CommitsGitScreenState();
}

class CommitsGitScreenState extends State<CommitsGitScreen> {
  final GitHubService _gitHubService = GitHubService();
  List<dynamic> _commits = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchCommits();
  }

  void _fetchCommits() async {
    try {
      final commits = await _gitHubService.fetchCommits(
          'JoaquinLazaro26', 'GestionMatriculas');
      setState(() {
        _commits = commits;
        _loading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar los commits')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Commits'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _commits.length,
              itemBuilder: (context, index) {
                final commit = _commits[index];
                return ListTile(
                  title: Text(commit['commit']['message']),
                  subtitle: Text(commit['commit']['author']['name']),
                );
              },
            ),
    );
  }
}
