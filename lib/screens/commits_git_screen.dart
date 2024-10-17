import 'package:flutter/material.dart';
import '../services/git_api.dart';
import 'owner_repo_info.dart';
import 'commits_list.dart';

class CommitsGitScreen extends StatefulWidget {
  const CommitsGitScreen({super.key});

  @override
  CommitsGitScreenState createState() => CommitsGitScreenState();
}

class CommitsGitScreenState extends State<CommitsGitScreen> {
  final GitHubService _gitHubService = GitHubService();
  List<dynamic> _commits = [];
  bool _loading = true;
  //Setear parámetros de inicio
  String owner = "JoaquinLazaro26";
  String repo = "GitHistorialFlutter";

  @override
  void initState() {
    super.initState();
    _fetchCommits();
  }

  void _fetchCommits() async {
    setState(() {
      _loading = true;
    });

    try {
      final commits = await _gitHubService.fetchCommits(owner, repo);
      if (!mounted) return;

      setState(() {
        _commits = commits;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _commits = [];
        _loading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al cargar los commits')),
        );
      }
    }
  }

  void selectRepoDialog() async {
    //Nombre del Owner para buscar por repositorios
    String newOwner = 'JoaquinLazaro26';
    List<dynamic> repositories = [];

    try {
      repositories = await _gitHubService.fetchRepositories(newOwner);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al buscar repositorios')),
        );
      }
      return;
    }

    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Seleccionar Repositorio'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: repositories.length,
              itemBuilder: (context, index) {
                final repo = repositories[index]['name'];
                return ListTile(
                  title: Text(repo),
                  onTap: () {
                    setState(() {
                      owner = newOwner;
                      this.repo = repo;
                    });
                    _fetchCommits();
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Commits'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                owner = "JoaquinLazaro26";
                repo = "GitHistorialFlutter";
              });
              _fetchCommits();
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                owner = "";
                repo = "";
                _commits = [];
              });
              _gitHubService.fetchCommits(owner, repo);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          OwnerRepoInfo(owner: owner, repo: repo),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _commits.isEmpty
                    ? const Center(child: Text('No se encontraron commits'))
                    : CommitsList(commits: _commits),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: selectRepoDialog,
        tooltip: 'Seleccionar Repositorio',
        child: const Icon(Icons.search),
      ),
    );
  }
}
