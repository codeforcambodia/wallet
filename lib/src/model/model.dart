class User_Data {
  String id = "";
  String displayName="";
  String email= "";
  String photoUrl= "";
  String password="";

  User_Data(String displayName, String email, String id, String photoUrl, String password) : 
    this.displayName = displayName,
    this.email = email,
    this.id = id,
    photoUrl = photoUrl,
    password = password;
}