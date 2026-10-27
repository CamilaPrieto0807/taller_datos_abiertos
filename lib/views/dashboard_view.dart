import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/endpoints.dart';
import '../widgets/endpoint_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Datos Abiertos de Colombia')),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 600;
                return GridView.builder(
                  padding: EdgeInsets.all(wide ? 24 : 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: wide ? 20 : 12,
                    mainAxisSpacing: wide ? 20 : 12,
                    childAspectRatio: wide ? 1.1 : 0.9,
                  ),
                  itemCount: endpoints.length,
                  itemBuilder: (_, i) => EndpointCard(
                    endpoint: endpoints[i],
                    onTap: () => context.pushNamed(
                      'list',
                      pathParameters: {'endpoint': endpoints[i].key},
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
}