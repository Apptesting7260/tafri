import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/explore/map/model/mapmodel.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/local_storage.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class MapActivityController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    var homeData = Get.arguments;
    getMap();
    getUserLocation();
    super.onInit();
  }

  GoogleMapController? mapController;
  Rxn<loc.LocationData> currentLocation = Rxn<loc.LocationData>();
  final LatLng initialPosition = LatLng(52.3731, 4.8922);


  Future<void> getUserLocation() async {
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

    // Move the camera to the user's location
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(userLocation.latitude!, userLocation.longitude!),
          zoom: 15,
        ),
      ),
    );
  }

  String uid = LocalStorage.getUid().toString();
  String token = LocalStorage.getToken().toString();

  final api = ApiServices();
  var mapData = MapModel().obs;
  var mapLoading = false.obs;
  var mapError = ''.obs;



  Future<void> getMap() async{
    mapLoading.value = true;
    var header = {
      'Authorization': 'Bearer $token'
    };
    try{
      final response = await api.get(EndPoints.mapicons,headers: header);
      print(response.body);
      if(response.statusCode == 200){
        mapError.value = '';
        mapData.value = MapModel.fromJson(response.body);
        print('map == ${mapData.value}');
        await addMarkers();
      }else{
        mapError.value = 'Error';
      }
    }catch(e){
      mapError.value = e.toString();
      print('error == ${e.toString()}');
    }
    mapLoading.value = false;
  }


  Set<Marker> markers = <Marker>{}.obs;

  Future<void> addMarkers() async {
    final List<Result>? results = mapData.value.result;
    if (results != null) {
      markers.clear();
      for (var result in results) {
        final latitude = double.tryParse(result.latitude ?? '');
        final longitude = double.tryParse(result.longitude ?? '');

        if (latitude != null && longitude != null) {
          final icon = await getCustomIcon(result.icon ?? '');
          final marker = Marker(
            markerId: MarkerId(result.name ?? 'unknown'),
            position: LatLng(latitude, longitude),
            icon: icon,
            infoWindow: InfoWindow(title: result.name),
          );
          markers.add(marker);
        }
      }
      update();
    }
  }

  Future<BitmapDescriptor> getCustomIcon(String iconUrl) async {
    try {
      final ByteData byteData = await NetworkAssetBundle(Uri.parse(iconUrl)).load("");
      final Uint8List bytes = byteData.buffer.asUint8List();
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ui.Image image = frameInfo.image;

      final double size = 100.0;
      final double circleRadius = size / 2;
      final double whiteCircleRadius = circleRadius * 0.9;
      final double imageSize = whiteCircleRadius;

      final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(pictureRecorder);
      final Paint yellowPaint = Paint()..color = clrYellow;
      final Paint whitePaint = Paint()..color = Colors.white;

      canvas.drawCircle(Offset(circleRadius, circleRadius), circleRadius, yellowPaint);

      canvas.drawCircle(Offset(circleRadius, circleRadius), whiteCircleRadius, whitePaint);

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
    } catch (e) {
      print('Error fetching icon: $e');
      return BitmapDescriptor.defaultMarker;
    }
  }

}