import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yardex/controllers/marker_provider.dart';
import 'package:yardex/models/marker.dart';
import 'package:yardex/views/widgets/modal_bottom_sheet.dart';

class YardexMap extends ConsumerStatefulWidget {
  const YardexMap({super.key});

  @override
  ConsumerState<YardexMap> createState() => _YardexMapState();
}

class _YardexMapState extends ConsumerState<YardexMap> {
  static const home = LatLng(26.206, -98.356);
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await ref.read(markerNotifierProvider.notifier).loadMarkers();
    });
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void _handleMarkerTap(CustomMarker marker){
    print('FUCKING WORKKRKKKKKKKK : ${marker.servicerId}');
    showModalBottomSheet(context: context, builder: (BuildContext context){
      return MarkerModalBottomSheet(marker: marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    final markerList = ref.watch(markerNotifierProvider);
    print('THIS IS NOT FUCKING LOADING:  $markerList');
    Set<Marker> mapMarkers = markerList.map((marker) {
      return Marker(
        markerId: MarkerId(marker.id),
        position: LatLng(marker.latitude, marker.longitude),
        infoWindow: InfoWindow(title: marker.servicerId),
        onTap: () {
          _handleMarkerTap(marker);
        },
      );
    }).toSet();

    return GoogleMap(
      onMapCreated: (controller) {
        mapController = controller;
      },
      initialCameraPosition: CameraPosition(target: home, zoom: 17),
      markers: mapMarkers,
      mapType: MapType.terrain,
      zoomControlsEnabled: false,
    );
  }
}
