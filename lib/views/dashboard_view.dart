import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/endpoints.dart';
import '../widgets/endpoint_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Datos Abiertos de Colombia')),
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.95,
          ),
          itemCount: endpoints.length,
          itemBuilder: (_, i) => EndpointCard(
            endpoint: endpoints[i],
            onTap: () => context.pushNamed(
              'list',
              pathParameters: {'endpoint': endpoints[i].key},
            ),
          ),
        ),
      );
}