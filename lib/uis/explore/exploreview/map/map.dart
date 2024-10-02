import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plusone/uis/explore/exploreview/map/controller/mapcontroller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';

class MapExploreUi extends GetWidget<MapExploreController> {
  MapExploreUi({super.key});


  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonUi.appBar(),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Obx(() =>
                  controller.mapLoading.value
                      ? Expanded(
                      child: Center(
                          child: CommonUi.scaffoldLoading(color: clrYellow)
                      )
                  ) : GoogleMap(
                    onMapCreated: (GoogleMapController googleMapController) {
                      controller.mapController = googleMapController;
                      controller.addMarkerWithImage();
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          double.parse(controller.latitude!),
                          double.parse(controller.longitude!)
                      ),
                      // target: controller.currentLocation.value != null
                      //     ? LatLng(
                      //     double.parse(controller.latitude!),
                      //     double.parse(controller.longitude!))
                      //     : controller.initialPosition,
                      zoom: 14.0,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    markers: Set<Marker>.from(controller.markers),
                  ),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}