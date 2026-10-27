import 'package:flutter/material.dart';

import '../config/endpoints.dart';
import '../models/api_entity.dart';
import '../services/api_colombia_service.dart';
import '../widgets/entity_image.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';
import 'entity_list_view.dart' show ViewState;

class EntityDetailView extends StatefulWidget {
  final EndpointConfig endpoint;
  final int id;
  const EntityDetailView({super.key, required this.endpoint, required this.id});

  @override
  State<EntityDetailView> createState() => _EntityDetailViewState();
}

class _EntityDetailViewState extends State<EntityDetailView> {
  final _service = ApiColombiaService();
  ViewState _state = ViewState.loading;
  ApiEntity? _item;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _state = ViewState.loading);
    try {
      final data = await _service.getById<ApiEntity>(
        widget.endpoint.path,
        widget.id,
        widget.endpoint.fromJson,
      );
      if (!mounted) return;
      setState(() {
        _item = data;
        _state = ViewState.success;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.message;
        _state = ViewState.error;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Ocurrió un error inesperado';
        _state = ViewState.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(_item?.title ?? 'Detalle')),
        body: switch (_state) {
          ViewState.loading => const LoadingView(),
          ViewState.error => ErrorView(message: _error, onRetry: _load),
          ViewState.success => _buildContent(context, _item!),
        },
      );

  Widget _buildContent(BuildContext context, ApiEntity item) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.imageUrl != null)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: EntityImage(
                  url: item.imageUrl,
                  size: MediaQuery.of(context).size.width - 32,
                  height: 240,
                ),
              ),
            ),
          const SizedBox(height: 16),
          Text(item.title, style: textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(item.description, style: textTheme.bodyLarge),
          const SizedBox(height: 16),
          ...item.details.entries.map(
            (e) => ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(e.key,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(e.value),
            ),
          ),
        ],
      ),
    );
  }
}