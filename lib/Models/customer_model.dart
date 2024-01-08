 class CustomerModel{

String?username;
String?email;
String?password;

CustomerModel({  required this.email, required this.username, required this.password});



Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map.addAll({
      'email': email,
      'username': username,
      'password': password,
     
    });
    return map;
  }



}