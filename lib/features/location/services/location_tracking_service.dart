import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:maintly_app/core/heleprs/print_helper.dart';
import 'package:maintly_app/core/service_locator/service_locator.dart';
import 'package:maintly_app/features/location/services/technician_location_api_service.dart';

class LocationTrackingService {
  LocationTrackingService({this.updateInterval = const Duration(minutes: 1)});

  final Duration updateInterval;

  final TechnicianLocationApiService _api = serviceLocator<TechnicianLocationApiService>();

  Timer? _timer;

  bool get isRunning => _timer != null;

  Future<void> start() async {
    if (isRunning) {
      return;
    }

    pr(null, 'LocationTrackingService started');

    await _sendCurrentLocation();

    _timer = Timer.periodic(updateInterval, (_) => _sendCurrentLocation());
  }

  Future<void> stop() async {
    _timer?.cancel();
    _timer = null;

    pr(null, 'LocationTrackingService stopped');
  }

  Future<void> _sendCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();

      await _api.updateLocation(position);
    } catch (e) {
      pr(e, 'LocationTrackingService');
    }
  }
}
