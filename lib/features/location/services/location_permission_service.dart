import 'package:geolocator/geolocator.dart';
import 'package:maintly_app/features/location/enums/location_permission_status.dart';

class LocationPermissionService {
  const LocationPermissionService();

  Future<LocationPermissionStatus> checkPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return LocationPermissionStatus.serviceDisabled;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    switch (permission) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return LocationPermissionStatus.granted;

      case LocationPermission.denied:
        return LocationPermissionStatus.denied;

      case LocationPermission.deniedForever:
        return LocationPermissionStatus.deniedForever;

      case LocationPermission.unableToDetermine:
        return LocationPermissionStatus.denied;
    }
  }

  Future<bool> isServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  Future<void> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }

  Future<void> openAppSettings() {
    return Geolocator.openAppSettings();
  }
}
