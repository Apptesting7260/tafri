import 'package:get/get.dart';
import 'package:plusone/uis/explore/exploreview/model/exploreviewui_model.dart';
import 'package:plusone/utils/tostmsg.dart';
import '../../../../../../../networking/apiservices.dart';
import '../../../../../../../networking/endpoints.dart';
import '../../../../../../../utils/local_storage.dart';
import '../model/attend_review_model.dart';

class AttendReviewController extends GetxController{

  List<Going>? goinglist;
  String? actid;

  @override
  void onInit() {
    // TODO: implement onInit
    final args = Get.arguments as Map<String, dynamic>;
    goinglist = args["going"];
    actid = args["actid"]?.toString();
    super.onInit();
  }


  final api = ApiServices();
  var activityLoading = false.obs;
  var attData = AttendanceConfirmModel().obs;
  var attError = ''.obs;

  Future<void> attapi(String? actid, String? id, bool att,int index) async{

    Map body = {
      'activity_id': actid,
      'user_id': id,
      'user_attendance': att == false ? '1' : '0'
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    activityLoading.value = true;

    try{
      final response = await api.post(EndPoints.attconfirm, body, headers: header);
      if(response.statusCode == 200){
        attError.value = '';
        print('home data == ${response.body}');
        attData.value = AttendanceConfirmModel.fromJson(response.body);
        goinglist?[index].userAttendance = att == true ? false : true;
        showTostMsg('Attendance status updated successfully');
      }else{
        print('error == ${response.body}');
        attError.value = 'ERROR';
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      attError.value = e.toString();
    }
    activityLoading.value = false;
  }

}