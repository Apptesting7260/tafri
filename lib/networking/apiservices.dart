import 'package:get/get.dart';

class ApiServices extends GetConnect{

  // Future<Response> postApi({required String url,required dynamic body, Map<String, String>? headers}) async{
  //   try{
  //       var response = await post(url, body,headers: headers);
  //       print('response == ${response.body} ${response.statusCode}');
  //       return _handleResponse(response) ;
  //   }catch(e){
  //     print('error ==  ${e.toString()}');
  //     return _handleError(e);
  //   }
  // }
  //
  //
  // Response _handleResponse(Response response) {
  //   if(response.statusCode == 200){
  //     return response;
  //   }else{
  //     return Response(
  //       statusCode: response.statusCode,
  //       statusText: response.statusText
  //     );
  //   }
  // }
  //
  // Response _handleError(var error){
  //   String errorMessage = 'An error occurred';
  //   if(error is GetHttpException){
  //     errorMessage = 'Network error ${error.message}';
  //   }
  //   return Response(
  //     statusCode: 1,
  //     statusText: errorMessage
  //   );
  // }

}