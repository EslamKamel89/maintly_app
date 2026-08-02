import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maintly_app/core/router/app_routes_names.dart';
import 'package:maintly_app/core/service_locator/service_locator.dart';
import 'package:maintly_app/features/location/enums/location_permission_status.dart';
import 'package:maintly_app/features/location/services/location_permission_service.dart';
import 'package:maintly_app/features/splash_and_on_boarding/helpers/continue_to_app.dart';

class LocationPermissionRequiredPage extends StatefulWidget {
  const LocationPermissionRequiredPage({super.key, required this.status});

  final LocationPermissionStatus status;

  @override
  State<LocationPermissionRequiredPage> createState() => _LocationPermissionRequiredPageState();
}

class _LocationPermissionRequiredPageState extends State<LocationPermissionRequiredPage>
    with WidgetsBindingObserver {
  bool get _isIOS => Platform.isIOS;
  bool _isCheckingPermission = false;
  bool _isOpeningSettings = false;
  LocationPermissionService get _locationService => serviceLocator<LocationPermissionService>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermissionAndContinue();
    }
  }

  Future<void> _checkPermissionAndContinue() async {
    if (_isCheckingPermission) {
      return;
    }

    _isCheckingPermission = true;

    if (mounted) {
      setState(() {});
    }

    final status = await _locationService.checkPermission();

    if (!mounted) {
      return;
    }

    if (status == LocationPermissionStatus.granted) {
      await continueToApp();

      return;
    }

    if (status != widget.status) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutesNames.locationPermissionRequired,
        arguments: status,
      );

      return;
    }

    _isCheckingPermission = false;
    setState(() {});
  }

  Future<void> _openSettings() async {
    if (_isOpeningSettings) {
      return;
    }

    _isOpeningSettings = true;

    if (mounted) {
      setState(() {});
    }

    if (widget.status == LocationPermissionStatus.serviceDisabled) {
      await _locationService.openLocationSettings();
    } else {
      await _locationService.openAppSettings();
    }

    _isOpeningSettings = false;

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _retry() async {
    await _checkPermissionAndContinue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Required')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 52,
              backgroundColor: _color.withOpacity(.12),
              child: Icon(_icon, size: 56, color: _color),
            ).animate().scale().fadeIn(),
            const SizedBox(height: 28),
            Text(
              _title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            Text(
              _description,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, height: 1.5),
            ),
            const SizedBox(height: 28),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Why Maintly needs your location',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      leading: Icon(Icons.route),
                      title: Text('Dispatch the nearest technician'),
                    ),
                    ListTile(
                      leading: Icon(Icons.assignment_turned_in_outlined),
                      title: Text('Update active work orders'),
                    ),
                    ListTile(
                      leading: Icon(Icons.schedule),
                      title: Text('Provide accurate arrival estimates'),
                    ),
                  ],
                ),
              ),
            ).animate(delay: 150.ms).fadeIn().slideY(begin: .15),
            const SizedBox(height: 18),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What you need to do',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 14),
                    Text(_advice, style: const TextStyle(height: 1.5)),
                  ],
                ),
              ),
            ).animate(delay: 250.ms).fadeIn().slideY(begin: .15),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _isOpeningSettings ? null : _openSettings,
              icon: const Icon(Icons.settings),
              label: Text(_button),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _isCheckingPermission ? null : _retry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
            const SizedBox(height: 12),
            Text(
              'Location data is used only while performing maintenance work and is never shared with customers.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData get _icon {
    switch (widget.status) {
      case LocationPermissionStatus.serviceDisabled:
        return Icons.location_disabled_rounded;
      case LocationPermissionStatus.deniedForever:
        return Icons.location_disabled_outlined;
      case LocationPermissionStatus.denied:
        return Icons.location_searching_rounded;
      case LocationPermissionStatus.granted:
        return Icons.location_on;
    }
  }

  Color get _color {
    switch (widget.status) {
      case LocationPermissionStatus.serviceDisabled:
        return Colors.orange;
      case LocationPermissionStatus.deniedForever:
        return Colors.red;
      case LocationPermissionStatus.denied:
        return Colors.blue;
      case LocationPermissionStatus.granted:
        return Colors.green;
    }
  }

  String get _title {
    switch (widget.status) {
      case LocationPermissionStatus.serviceDisabled:
        return 'Location Services Are Turned Off';
      case LocationPermissionStatus.deniedForever:
        return 'Location Permission Permanently Denied';
      case LocationPermissionStatus.denied:
        return 'Location Permission Required';
      case LocationPermissionStatus.granted:
        return 'Location Ready';
    }
  }

  String get _description {
    switch (widget.status) {
      case LocationPermissionStatus.serviceDisabled:
        return 'Maintly cannot receive your live technician location because your device GPS is currently disabled.';
      case LocationPermissionStatus.deniedForever:
        return 'Location access has been permanently denied. You must enable it from the system settings.';
      case LocationPermissionStatus.denied:
        return 'Maintly needs your location to dispatch the nearest technician and update work orders in real time.';
      case LocationPermissionStatus.granted:
        return '';
    }
  }

  String get _advice => _isIOS
      ? (widget.status == LocationPermissionStatus.serviceDisabled
            ? 'Open iPhone Settings → Privacy & Security → Location Services and turn Location Services ON.'
            : 'Open iPhone Settings → Maintly → Location and choose While Using the App.')
      : (widget.status == LocationPermissionStatus.serviceDisabled
            ? 'Turn on Device Location (GPS) from Android Quick Settings or Settings → Location.'
            : 'Open Android Settings → Apps → Maintly → Permissions → Location and allow While using the app.');

  String get _button => widget.status == LocationPermissionStatus.serviceDisabled
      ? (_isIOS ? 'Open Location Settings' : 'Enable GPS')
      : 'Open Settings';
}
