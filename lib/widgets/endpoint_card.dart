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
          child: LayoutBuilder(
            builder: (context, constraints) {
              final big = constraints.maxWidth > 260;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: big ? 44 : 30,
                      backgroundColor:
                          endpoint.color.withValues(alpha: 0.15),
                      child: Icon(endpoint.icon,
                          size: big ? 46 : 32, color: endpoint.color),
                    ),
                    SizedBox(height: big ? 18 : 12),
                    Text(
                      endpoint.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: big ? 22 : 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      endpoint.description,
                      textAlign: TextAlign.center,
                      style: big
                          ? Theme.of(context).textTheme.bodyLarge
                          : Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
}