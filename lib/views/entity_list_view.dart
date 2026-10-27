import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/endpoints.dart';
import '../models/api_entity.dart';
import '../models/department.dart';
import '../models/touristic_attraction.dart';
import '../services/api_colombia_service.dart';
import '../widgets/entity_image.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';

enum ViewState { loading, success, error }

class EntityListView extends StatefulWidget {
  final EndpointConfig endpoint;
  const EntityListView({super.key, required this.endpoint});

  @override
  State<EntityListView> createState() => _EntityListViewState();
}

class _EntityListViewState extends State<EntityListView> {
  final _service = ApiColombiaService();
  ViewState _state = ViewState.loading;
  List<ApiEntity> _items = [];
  Map<int, String> _departmentImages = {};
  String _error = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _state = ViewState.loading);
        try {
      final data = await _service.getList<ApiEntity>(
        widget.endpoint.path,
        widget.endpoint.fromJson,
      );
      final departmentImages = <int, String>{};
      if (widget.endpoint.path == 'Department') {
        try {
          final attractions = await _service.getList<TouristicAttraction>(
            'TouristicAttraction',
            TouristicAttraction.fromJson,
          );
          for (final attraction in attractions) {
            final departmentId = attraction.departmentId;
            final imageUrl = attraction.imageUrl;
            if (departmentId != null && imageUrl != null) {
              departmentImages.putIfAbsent(departmentId, () => imageUrl);
            }
          }
        } on ApiException catch (e) {
          debugPrint(
            'No se pudieron cargar fotos de departamentos: ${e.message}',
          );
        }
      }
      if (widget.endpoint.sortByTitle) {
        data.sort((a, b) => a.title.compareTo(b.title));
      }
      if (!mounted) return;
      setState(() {
        _items = data;
        _departmentImages = departmentImages;
        _state = ViewState.success;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.message;
        _state = ViewState.error;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Ocurrió un error inesperado';
        _state = ViewState.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.endpoint.title)),
        body: switch (_state) {
          ViewState.loading => const LoadingView(),
          ViewState.error => ErrorView(message: _error, onRetry: _load),
          ViewState.success => _items.isEmpty
              ? const Center(child: Text('No hay datos disponibles'))
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _items.length,
                    itemBuilder: (_, i) {
                      final item = _items[i];
                      final imageUrl = item is Department
                          ? _departmentImages[item.id]
                          : item.imageUrl;
                      return Card(
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: EntityImage(url: imageUrl),
                          ),
                          title: Text(item.title),
                          subtitle: item.subtitle == null
                              ? null
                              : Text(item.subtitle!,
                                  maxLines: 2, overflow: TextOverflow.ellipsis),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.pushNamed(
                            'detail',
                            pathParameters: {
                              'endpoint': widget.endpoint.key,
                              'id': '${item.id}',
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
        },
      );
}
