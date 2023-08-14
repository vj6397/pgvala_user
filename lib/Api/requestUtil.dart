import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestUtil{
  final endpoint='https://davaivala.shop/';
  final token='Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3MjMyODkxMTIsImlhdCI6MTY5MTc1MzExMiwic2NvcGUiOiJhY2Nlc3NfdG9rZW4iLCJzdWIiOiIxIn0.3-KvHCHUgbOBNo7wxI5Zz83DRg2tWDz6vNkjf3riVWM';

  Future<http.Response> register_user (name,contact,city,state,address,username,
      dob,profession,working_place,course){
    return http.post(Uri.parse(endpoint+'register_user/'),
        headers: {"accept": "application/json",
          "Content-Type": "application/json"},
        body: jsonEncode ({
          "name": name,
          "contact": contact,
          "city": city,
          "state": state,
          "address": address,
          "username":username,
          "dob": dob,
          "profession": profession,
          "working_place": working_place,
          "course": course
        })
    );
  }

  Future<http.Response> cityList() async{
    return  http.get(Uri.parse(endpoint+'get_city_list/'),
      headers: {'Authorization': token},
    );
  }

  Future<http.Response> localityList(city) async{
    return  http.get(Uri.parse(endpoint+'get_city_locality_list/?city=$city'),
      headers: {'Authorization': token},
    );
  }

  Future<http.Response> qrResult(qr_text) async{
    return  http.get(Uri.parse(endpoint+'qr-scan-result/?qrid=$qr_text'),
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

  Future<http.Response> shedule_visit (date,accid,roomid,time){
    return http.post(Uri.parse(endpoint+'visting_time/'),
        headers: {"accept": "application/json",
          'Authorization': token,
          "Content-Type": "application/json"},
        body: jsonEncode (
            {
              "date": date,
              "username": "username",
              "accid": accid,
              "status": "visit",
              "roomid": roomid,
              "visting_time": time,
              "agg_fee": 0
            }
        ));
  }

  Future<http.Response> get_owner(accid) async{
    return  http.get(Uri.parse(endpoint+'get-owner-contact/?accid=$accid'),
      headers: {'Authorization': token},
    );
  }

  Future<http.Response> login(number, otp){
    return http.post(Uri.parse(endpoint+'app_login'),
        headers: {"accept": "application/json",
          "Content-Type": "application/json"},
        body: jsonEncode ({"contact": number, "otp": otp,"user_type": "user"}));
  }

  Future<http.Response> visitTime() async{
    return  http.get(Uri.parse(endpoint+'vist_schedule/'),
      headers: {'Authorization': token},
    );
  }
  Future<http.Response> cancelVisit(entry_id) async{
    return  http.get(Uri.parse(endpoint+'cancel_schedule/?id=$entry_id'),
      headers: {'Authorization': token},
    );
  }
}