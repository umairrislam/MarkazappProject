
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markazapp/Constant/City.dart';
import 'package:markazapp/Constant/colors.dart';
import 'package:markazapp/Screens/home_screen.dart';
import 'package:nb_utils/nb_utils.dart';



class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFE5E5E5),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () {
                const HomeScreen().launch(context, isNewTask: true);
              },
              child: Text(
                 'Skip',
              ),
            ),
          ],
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(30),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Start Your Journey with',
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'MaanStore Fashion',
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                        color: secondaryColor1,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                  'You will find great products and tools for your needs. We are 100% conscious of quality assurance. Thank you',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                        color: textColors,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
               
                  const SizedBox(height: 15),
                
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
