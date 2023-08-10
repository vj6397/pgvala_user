import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestUtil{
  final endpoint='https://davaivala.shop/';
  final token='Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3MjIxNjM4NDAsImlhdCI6MTY5MDYyNzg0MCwic2NvcGUiOiJhY2Nlc3NfdG9rZW4iLCJzdWIiOiJhY2MwNiJ9.D9wDOUSPuy0RX_QOH0Zhx8QiSZ1GLo3jfoaHvRj39tE';

  Future<http.Response> cityList() async{
    return  http.get(Uri.parse(endpoint+'get_city_list/'),
      headers: {'Authorization': token},
    );
  }
  Future<http.Response> resendOtp (number){
    return http.post(Uri.parse(endpoint+'resend_otp?contact=$number&user_type=user'));
  }

  Future<http.Response> accomodation_List(city) async{
    return  http.get(Uri.parse(endpoint+'accommodation_list/?city=$city'),
      headers: {'Authorization': token},
    );
  }

  Future<http.Response> login(number, otp){
    return http.post(Uri.parse(endpoint+'app_login'),
        headers: {"accept": "application/json",
          "Content-Type": "application/json"},
        body: jsonEncode ({"contact": number, "otp": otp,"user_type": "user"}));
  }

}