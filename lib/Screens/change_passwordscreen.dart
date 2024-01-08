import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
   final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160),
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
                   padding: const EdgeInsets.all(8.0),
                   child: Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                 ),
                        SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'The Password should have at least 6 characters',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ),
              ]
            ),),
        ),
      ),
      body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
         key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          
        
               SizedBox(height: 50,),
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
           SizedBox(height: 10,),
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
            controller: confirmPasswordController,
            obscureText: !isConfirmPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
              labelText: 'Confirm Password',
              labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  isConfirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isConfirmPasswordVisible = !isConfirmPasswordVisible;
                  });
                },
              ),
            ),
          ),
        ),
        Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            "SUBMIT",
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
        ],),
      ),
    ),);
  }
}