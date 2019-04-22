class User_Data {
  String id = "";
  String displayName="";
  String email= "";
  String photoUrl= "";
  String password="";
  String name="";
  String first_name = "";
  String last_name="";

  User_Data.fromGoogle(String displayName, String email, String id, String photoUrl, String password) : 
    this.displayName = displayName,
    this.email = email,
    this.id = id,
    photoUrl = photoUrl,
    password = password;

  User_Data.fromFB(var fromFBs) {
    print(fromFBs);
  }

  User_Data();
}