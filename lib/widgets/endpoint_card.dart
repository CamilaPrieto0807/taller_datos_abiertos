import 'package:flutter/material.dart';

import '../config/endpoints.dart';

class EndpointCard extends StatelessWidget {
  final EndpointConfig endpoint;
  final VoidCallback onTap;
  const EndpointCard({super.key, required this.endpoint, required this.onTap});

  @override
  Widget build(BuildContext context) => Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: endpoint.color.withValues(alpha: 0.15),
                  child: Icon(endpoint.icon, size: 32, color: endpoint.color),
                ),
                const SizedBox(height: 12),
                Text(endpoint.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(endpoint.description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
      );
}