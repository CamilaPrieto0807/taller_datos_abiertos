import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/endpoints.dart';
import '../views/dashboard_view.dart';
import '../views/entity_detail_view.dart';
import '../views/entity_list_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Ruta no encontrada')),
    body: Center(child: Text('No existe la ruta: ${state.uri}')),
  ),
  routes: [
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardView(),
      routes: [
        GoRoute(
          path: 'list/:endpoint',
          name: 'list',
          builder: (context, state) {
            final endpoint = findEndpoint(state.pathParameters['endpoint']!);
            if (endpoint == null) return const DashboardView();
            return EntityListView(endpoint: endpoint);
          },
          routes: [
            GoRoute(
              path: ':id',
              name: 'detail',
              builder: (context, state) {
                final endpoint =
                    findEndpoint(state.pathParameters['endpoint']!);
                final id = int.tryParse(state.pathParameters['id']!);
                if (endpoint == null || id == null) {
                  return const DashboardView();
                }
                return EntityDetailView(endpoint: endpoint, id: id);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);