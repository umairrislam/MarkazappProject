import 'package:flutter/material.dart';
import 'package:markazapp/Screens/Forgotpassword_screen.dart';
import 'package:markazapp/Screens/navigationBarscreen.dart';
import 'package:markazapp/Services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   late APIService apiService;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
   @override
  void initState() {
    apiService = APIService();
    super.initState();
  }


void login() async {
    if (_formKey.currentState!.validate()) {
      final userName = userNameController.text;

      final password = passwordController.text;
      print("Sending login request...");
      try {
        bool success = await apiService.loginCustomer(userName, password);
        print("Login request completed with success: $success");

        if (success) {
          SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('username',userName.toString(), ); // Change this to the actual email if available
        sp.setBool('isLogin', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationBarScreen()),
        );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Login Successful 💫✨"),
            backgroundColor:Colors.teal),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("Login failed. Please check your username and password."),
            backgroundColor:Color(0xFFE640A79),
          ));
        }
      } catch (error) {
        print("Login request failed with error: $error");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("An error occurred during login. Please try again."),
          backgroundColor: Colors.red,
        ));
      }
    }

  }
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
       resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(59),
        child: Material(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ]
            ),),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: Form(
           key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Container(child: Text("Sign in",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),),
              SizedBox(height:50,),
              Container(
              decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              offset: Offset(0, 2),
            ),
          ],
              ),
              child: TextFormField(
          controller: userNameController,
          decoration: InputDecoration(
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
              labelText: 'Username',
              labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
              border: InputBorder.none),
              ),
            ),
              SizedBox(height: 16.0),
              Container(
              decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              offset: Offset(0, 2),
            ),
          ],
              ),
              child: TextFormField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            fillColor: Colors.white,
            contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
          ),
              ),
            ),
              SizedBox(height: 32.0),
             Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: ElevatedButton(
          onPressed: login,
          child: Text(
            "LOGIN",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Color(0xFFE640A19);
                }
                return Color(0xFFE640A79);
              }),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)))),
              ),
            ),
              SizedBox(height: 5.0),
              GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Text("Forgot your password? "),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
             
            ],
          ),
        ),
      ),
    );
  }
}
