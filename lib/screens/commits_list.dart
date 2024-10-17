import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommitsList extends StatelessWidget {
  final List<dynamic> commits;

  const CommitsList({super.key, required this.commits});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: commits.length,
      itemBuilder: (context, index) {
        final commit = commits[index];
        final author = commit['commit']['author']['name'];
        final message = commit['commit']['message'];
        final date = commit['commit']['author']['date'];
        final avatarUrl =
            commit['author'] != null ? commit['author']['avatar_url'] : null;

        final formattedDate =
            DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(date));

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: avatarUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(avatarUrl),
                    )
                  : const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.split('\n').first,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (message.split('\n').length > 1)
                    Text(
                      message.split('\n').skip(1).join('\n'),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Autor: $author'),
                    Text('Fecha: $formattedDate'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
