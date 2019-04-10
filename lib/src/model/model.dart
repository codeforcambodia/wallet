class User_Data {
  String id = "";
  String displayName="";
  String email= "";
  String photoUrl= "";

  User_Data(String displayName, String email, String id, String photoUrl) : 
    this.displayName = displayName,
    this.email = email,
    this.id = id,
    this.photoUrl = photoUrl;
}