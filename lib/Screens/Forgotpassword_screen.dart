import 'package:flutter/material.dart';
import 'package:markazapp/Screens/otp_auth.dart';
import 'package:markazapp/Services/api_service.dart';
import 'package:nb_utils/nb_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
   late APIService apiService;
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
   @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
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
                SizedBox(height:10 ,),
                 Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom:10),
                  child: Container(
                    child: Text(
                      "Forgot password",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]
            ),),
        ),
      ),
      body: Form(
       key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
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
            controller: emailController,
            decoration: InputDecoration(
                fillColor: Colors.white,
                contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                border: InputBorder.none),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
          child: ElevatedButton(
            onPressed: () {
              OtpAuthScreen().launch(context);
            },
            child: Text(
              "Send",
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
          ],
        ),
      ),
    ),);
  }
}