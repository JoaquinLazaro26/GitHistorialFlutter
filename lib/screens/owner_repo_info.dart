import 'package:flutter/material.dart';

class OwnerRepoInfo extends StatelessWidget {
  final String owner;
  final String repo;

  const OwnerRepoInfo({
    super.key,
    required this.owner,
    required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Owner: $owner',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Repo: $repo',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
