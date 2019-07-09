import 'dart:convert';

class ProfileModel {
  String first_name;
  String mid_name;
  String last_name;
  String gender;
  String profile_img;
  String wallet;
  String document_id;
  String user_status;
  String tempToken;
  String create_id;
  String updated_id;

  convertToJson() {
    Map<String,dynamic> data = {
      "first_name": first_name,
      "mid_name": mid_name,
      "last_name": last_name,
      "gender": gender,
      "wallet": wallet,
      "document_id": document_id,
      "user_status": user_status,
      "tempToken": tempToken,
      "create_id": create_id,
      "updated_id": updated_id
    };
    // var convert = json.encode(data);
    return data;
  }
}