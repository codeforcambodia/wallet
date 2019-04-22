class User_Data {
  final String id;
  // final String displayName;
  // final String email;
  // final String photoUrl;
  // final String password;
  final String name;
  final String firstName;
  final String lastName;

  // User_Data.fromGoogle(String displayName, String email, String id, String photoUrl, String password) : 
  //   this.displayName = displayName,
  //   this.email = email,
  //   this.id = id,
  //   photoUrl = photoUrl,
  //   password = password;

  User_Data.fromFB(Map<String, dynamic> parsedJson) :
    id = parsedJson['id'],
    name = parsedJson['name'],
    firstName = parsedJson['parsedJson'],
    lastName = parsedJson['pasredJson'];

}