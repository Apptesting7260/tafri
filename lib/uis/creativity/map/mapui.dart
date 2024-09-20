// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
// import 'package:plusone/utils/colors.dart';
// import 'package:plusone/utils/common.dart';
// import 'package:plusone/utils/size.dart';
//
// class Mapui extends StatefulWidget {
//   @override
//   _MapuiState createState() => _MapuiState();
// }
//
//
// class _MapuiState extends State<Mapui> {
//
//   final Creativitycontroller control =Get.find<Creativitycontroller>();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     control.getUserLocation();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 30,
//           ),
//           Padding(
//             padding:  EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
//             child: CommonUi.appBar(),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Obx(() => control.currentLocation.value == null
//               ? Expanded(child: Center(child: CommonUi.scaffoldLoading(color: clrYellow)))
//               : Expanded(
//             child: Stack(
//               alignment: AlignmentDirectional.bottomEnd,
//               children: [
//                 GoogleMap(
//                   markers: control.markers.toSet(),
//                   onTap: control.handleTap,
//                   onMapCreated: (controller) {
//                     control.mapController = controller;
//                   },
//                   initialCameraPosition: CameraPosition(
//                     target: control.currentLocation.value != null
//                         ? LatLng(control.currentLocation.value!.latitude!, control.currentLocation.value!.longitude!)
//                         : control.initialPosition,
//                     zoom: 14.0,
//                   ),
//                   myLocationEnabled: true,
//                   myLocationButtonEnabled: true,
//                 ),
//                 control.markers.isEmpty ? const SizedBox() : Container(
//                   height: 150,
//                   decoration: BoxDecoration(
//                       color: clrWhite,
//                     borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
//                   ),
//                 )
//               ],
//             ),
//           ),)
//         ],
//       )
//     );
//   }
//
// }




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';

class Mapui extends StatefulWidget {
  @override
  State<Mapui> createState() => _MapuiState();
}

class _MapuiState extends State<Mapui> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Creativitycontroller>(
      init: Creativitycontroller(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                child: CommonUi.appBar(),
              ),
              const SizedBox(
                height: 10,
              ),
              controller.currentLocation.value == null
                  ? Expanded(child: Center(child: CommonUi.scaffoldLoading(color: clrYellow)))
                  : Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    GoogleMap(
                      markers: controller.markers.toSet(),
                      onTap: controller.handleTap,
                      onMapCreated: (GoogleMapController googleMapController) {
                        controller.mapController = googleMapController;
                      },
                      initialCameraPosition: CameraPosition(
                        target: controller.currentLocation.value != null
                            ? LatLng(controller.currentLocation.value!.latitude!, controller.currentLocation.value!.longitude!)
                            : controller.initialPosition,
                        zoom: 14.0,
                      ),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      // mapType: MapType.hybrid,
                    ),
                    controller.markers.isEmpty
                        ? const SizedBox()
                        : Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: clrWhite,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                controller.address.value,
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 15,
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.locController.value.text = controller.address.value;
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: clrBlacke),
                                  child: Text('Save',style: TextStyle(color: clrWhite),)
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

