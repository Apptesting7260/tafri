import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

class MapExploreController extends GetxController {

  late String? latitude;
  late String? longitude;
  late String? imageUrl;

  @override
  void onInit() {
    latitude = Get.arguments['latitude'];
    longitude = Get.arguments['longitude'];
    imageUrl = Get.arguments['image'];
    print('latitude longitude $latitude $longitude');
    getUserLocation();
    super.onInit();
  }

  GoogleMapController? mapController;
  Rxn<loc.LocationData> currentLocation = Rxn<loc.LocationData>();
  LatLng initialPosition = LatLng(52.3731, 4.8922);
  RxSet<Marker> markers = <Marker>{}.obs;
  var mapLoading = false.obs;

  Future<void> getUserLocation() async {
    // mapLoading.value = true;
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    final userLocation = await location.getLocation();
    currentLocation.value = userLocation;
    print('currnet $currentLocation');
    // mapLoading.value = false;

    // // Move the camera to the user's location
    // mapController?.animateCamera(
    //   CameraUpdate.newCameraPosition(
    //     CameraPosition(
    //       target: LatLng(userLocation.latitude!, userLocation.longitude!),
    //       zoom: 15,
    //     ),
    //   ),
    // );

    // await addMarkerWithImage();
  }


  Future<void> addMarkerWithImage() async {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      markers.clear();
      // final icon = await getCustomIcon(imageUrl!); // Pass image URL correctly
      // if (icon != null) {
        markers.add(
          Marker(
            markerId: MarkerId('activity_marker'),
            position: LatLng(double.parse(latitude!), double.parse(longitude!)),
            infoWindow: InfoWindow(
              title: Get.arguments['title'], // Title from arguments
            ),
            icon: BitmapDescriptor.defaultMarker, // Set custom icon
          ),
        );
        print('Marker added at $latitude, $longitude with icon: $imageUrl');
        update(); // Use this to trigger UI update
      // }
    }
  }


  Future<BitmapDescriptor> getCustomIcon(String iconUrl) async  {
    mapLoading.value = true;
    try {
      final http.Response response = await http.get(Uri.parse(iconUrl));
      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        final ui.Codec codec = await ui.instantiateImageCodec(bytes);
        final ui.FrameInfo frameInfo = await codec.getNextFrame();
        final ui.Image image = frameInfo.image;

        final double size = 100.0;
        final double circleRadius = size / 2;
        final double whiteCircleRadius = circleRadius * 0.9;
        final double imageSize = whiteCircleRadius;

        final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
        final Canvas canvas = Canvas(pictureRecorder);
        final Paint yellowPaint = Paint()..color = Colors.yellow;
        final Paint whitePaint = Paint()..color = Colors.white;

        // Draw the outer yellow circle
        canvas.drawCircle(Offset(circleRadius, circleRadius), circleRadius, yellowPaint);

        // Draw the inner white circle
        canvas.drawCircle(Offset(circleRadius, circleRadius), whiteCircleRadius, whitePaint);

        final Path clipPath = Path()
          ..addOval(Rect.fromCircle(center: Offset(circleRadius, circleRadius), radius: whiteCircleRadius));
        canvas.clipPath(clipPath);

        // Draw the image inside the circle
        final ui.Rect imageRect = Rect.fromLTWH(
          (size - imageSize) / 2,
          (size - imageSize) / 2,
          imageSize,
          imageSize,
        );
        final ui.Paint imagePaint = Paint()..filterQuality = ui.FilterQuality.high;
        canvas.drawImageRect(
          image,
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
          imageRect,
          imagePaint,
        );

        final ui.Image img = await pictureRecorder.endRecording().toImage(size.toInt(), size.toInt());
        final ByteData? byteDataPng = await img.toByteData(format: ui.ImageByteFormat.png);
        final Uint8List uint8List = byteDataPng!.buffer.asUint8List();

        return BitmapDescriptor.fromBytes(uint8List);
      }
    } catch (e) {
      print('Error fetching icon: $e');
    }
    print('done');
    mapLoading.value = false;

    // Return a default marker in case of failure
    return BitmapDescriptor.defaultMarker;
  }
}
