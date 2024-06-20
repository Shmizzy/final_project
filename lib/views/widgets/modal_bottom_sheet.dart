import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yardex/controllers/servicer_provider.dart';
import 'package:yardex/models/marker.dart';

class MarkerModalBottomSheet extends ConsumerStatefulWidget {
  final CustomMarker marker;

  MarkerModalBottomSheet({super.key, required this.marker});

  @override
  ConsumerState<MarkerModalBottomSheet> createState() =>
      _MarkerModalBottomSheetState();
}

class _MarkerModalBottomSheetState
    extends ConsumerState<MarkerModalBottomSheet> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await ref
          .read(servicerNotifierProvider.notifier)
          .loadServicer(widget.marker.servicerId);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedServicer = ref.watch(servicerNotifierProvider);
    if (selectedServicer == null) {
      return Container(
        height: 250,
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Container(
      height: 250,
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Text(selectedServicer.bio),
            Text(selectedServicer.servicesOffered.toString()),
            Text('average rating: ${selectedServicer.averageRating}'),
            ElevatedButton(
              onPressed: () async {
                context.go('/service-request');
              },
              child: Text('Request Service'),
            ),
          ],
        ),
      ),
    );
  }
}
