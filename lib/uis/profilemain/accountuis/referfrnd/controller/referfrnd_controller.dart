import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReferFrndController extends GetxController{

  final ProfilemainController profileController = Get.find<ProfilemainController>();

  RefreshController refreshController = RefreshController(initialRefresh: false);
  RefreshController refreshController1 = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> refresh() async{
    await profileController.viewProfile();
    refreshController.refreshCompleted();
    refreshController1.refreshCompleted();
  }

  String getWeek(int days) {
    switch (days) {
      case 7:
        return '1 week';
      case 14:
        return '2 weeks';
      case 21:
        return '3 weeks';
      case 28:
        return '4 weeks';
      case 30:
      case 31:
        return '1 month';
      case 60:
      case 61:
        return '2 months';
      case 90:
      case 91:
        return '3 months';
      case 180:
      case 181:
        return '6 months';
      case 365:
        return '12 months (1 year)';
      default:
        if (days < 7) {
          return  days > 2 ? '$days days' : '$days day';
        } else if (days > 7 && days < 30) {
          int weeks = days ~/ 7;
          return '$weeks weeks';
        } else {
          int months = days ~/ 30;
          return '$months months';
        }
    }
  }

}