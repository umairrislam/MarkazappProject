import 'package:flutter/material.dart';
import 'package:markazapp/Models/customer_model.dart';
import 'package:markazapp/Signinsignupscreens/Signin_screen.dart';
import 'package:markazapp/Services/api_service.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late APIService apiService;
  final uNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
   final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
   @override
  void initState() {
    apiService = APIService();
    super.initState();
  }
   void singUp() async {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final userName = uNameController.text;
      final password = passwordController.text;
      final customer =
          CustomerModel(email: email, username: userName, password: password);
      bool success = await apiService.createCustomer(customer);
      if (success) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUpScreen()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Registration Successful 💫✨"),
          backgroundColor: Colors.teal,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Registration field. Please try again."),
          backgroundColor: Color(0xFFE640A79),
        ));
      }
    }

  }
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
               key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 Container(child: Text("Sign up",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),),
                  SizedBox(height: 30.0),
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
                    controller: uNameController,
                    keyboardType: TextInputType.name,
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
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
              labelText: 'Email',
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
                 
                 
                  SizedBox(height: 20.0),
                 Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: ElevatedButton(
                    onPressed: singUp,
                    child: Text(
                      "SIGN UP",
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
                   Padding(
                     padding: const EdgeInsets.all(2.0),
                     child: GestureDetector(
                       onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           Container(
                             child: Text("Already have an account? "),
                           ),
                           Icon(
                             Icons.arrow_forward,
                             color: Colors.black,
                           )
                         ],
                       ),
                     ),
                   ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          height: 8,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("or Sign in with"),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          height: 8,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                         
                         
                        ),
                        child:    Image.network(
                          "https://static-00.iconduck.com/assets.00/facebook-icon-512x511-ircc9ves.png"
                        
                        ),
                      ),
                      SizedBox(width: 10.0),
                     
                      
                      Container(
                        width: 50,
                        height: 35,
                        decoration: BoxDecoration(
            
                          
                         
                        ),
                        child: Image.network(
                          "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-icon-logo-png-transparent-svg-vector-bie-supply-14.png"
                        
                        ),
                      ),
                     
                    ],
                  ),
                  SizedBox(height: 30.0),
                  
                ], // <-- Added this closing brace for Column
              ),
            ),
          ),
        ),
      ),
    );
  }
}
