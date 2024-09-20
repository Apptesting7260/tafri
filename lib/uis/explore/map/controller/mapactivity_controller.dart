import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/explore/explorelist/model/home_page_model.dart';
import 'package:plusone/uis/explore/map/model/mapmodel.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/local_storage.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/size.dart';

class MapActivityController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    homeData = Get.arguments;
    getMap();
    getUserLocation();
    super.onInit();
  }

  var homeData = HomePageModal();

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
    final List<MapResult>? results = mapData.value.result;
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


  showHomePop() async {
    Future.delayed(Duration.zero, () {
      return Get.dialog(AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          contentPadding:
          const EdgeInsets.only(left: 18,right: 18, top: 20,bottom: 30),
          content: SizedBox(
            width: Get.width * 0.87,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 35,
                    )),
                Center(
                  child: Image.asset(
                    "assets/icons/hifyicon.png",
                    height: 49,
                    width: 90,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                const Center(
                    child: Text(
                      "Welcome! Let’s get started",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    )),
                SizedBox(
                  height: Get.height * 0.012,
                ),
                const Center(
                  child: Text(
                    "To join activities, please become a PlusOnes member and complete your profile.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Nunito'),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.025,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.planMemUi);
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 18,right: 10,top: 12,bottom: 12,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: clrGreyLight),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/tajicon.png",
                          height: Get.height * 0.03,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                  child: Text(
                                    "Become a member",
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
                                  )),
                              Image.asset('assets/icons/arrow right.png',height: 14,)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.myprofileInnUi);
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 18,right: 10,top: 12,bottom: 12,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: clrGreyLight),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/person.png",
                          height: Get.height * 0.03,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                  child: Text("Complete profile",
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400))),
                              Image.asset('assets/icons/arrow right.png',height: 14)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )));
    });
  }


  changeIndicator(index, currentIndex) {
    homeData.result!.activities?[index].circleIndex?.value = currentIndex;
  }


  bool? isFavs = false;

  Future<bool?> changeFavApi(String? id) async{

    Map body = {
      'activity_id': id,
      'user_id': LocalStorage.getUid(),
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };


    try{
      final response = await api.post(EndPoints.changeFavurl, body,headers: header);
      if(response.statusCode == 200){
        isFavs = true;
        print('change data == ${response.body}');
        log(isFavs.toString());
        return isFavs;
      }else{
        print('error == ${response.body}');
        return false;
      }
    }catch(e){
      print('changeFav api error == ${e.toString()}');
      return false;

    }


  }

}