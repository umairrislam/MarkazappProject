import 'package:flutter/material.dart';
import 'package:markazapp/Screens/bussinessdetailscreen.dart';
import 'package:markazapp/Screens/meraProfitscreen.dart';
import 'package:markazapp/Signinsignupscreens/signup_screen.dart';
import 'package:markazapp/Widgets/leader_boardcard.dart';
import 'package:markazapp/Widgets/offerscard.dart';
import 'package:markazapp/Widgets/profile_screencard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Markaz',style: TextStyle(color: Colors.black),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProfileCard(),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.25,
                        child: LeaderboardCard()),
                    ),
                  ),
                  Expanded(
                    child: Container(
                       height: MediaQuery.of(context).size.height*0.27,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OffersCard(),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, ),
                child: Container(
                  child: Text(
                    "Account",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              ListTile(
                onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MeraProfitScreen()));
      },
                leading: Icon(Icons.attach_money),
                title: Text('Mera Profit', style: TextStyle(fontSize: 12)),
              ),
              buildDivider(),
              ListTile(
                onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessDetailScreen()));
      },
                leading: Icon(Icons.business),
                title: Text('Business Details', style: TextStyle(fontSize: 12)),
              ),
              buildDivider(),
              ListTile(
                leading: Icon(Icons.account_balance),
                title: Text('Profit Account', style: TextStyle(fontSize: 12)),
              ),
              buildDivider(),
              ListTile(
                leading: Icon(Icons.shop),
                title: Text('Followed Shops', style: TextStyle(fontSize: 12)),
              ),
              buildDivider(),
              ListTile(
                leading: Icon(Icons.view_list),
                title: Text('Catalogs Viewed', style: TextStyle(fontSize: 12)),
              ),
              buildDivider(),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('My Favorites', style: TextStyle(fontSize: 12)),
              ),
              buildDivider(),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('My Shares', style: TextStyle(fontSize: 12)),
              ),
              buildDivider(),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 5),
                child: Container(
                  child: Text(
                    "Help & Support",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Help', style: TextStyle(fontSize: 12)),
              ),
              buildDivider(),
              ListTile(
                leading: Icon(Icons.library_books),
                title: Text('Terms & Conditions', style: TextStyle(fontSize: 12)),
              ),
              buildDivider(),
              ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text('Privacy Policy', style: TextStyle(fontSize: 12)),
              ),
                buildDivider(),
               GestureDetector(
                 onTap: () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();

                  sp.clear();

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                 child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log out', style: TextStyle(fontSize: 12)),
                             ),
               ),
              buildDivider(),
              
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Follow us on Social Media",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                ],),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.facebook, color: Colors.white),
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.tiktok, color: Colors.white),
                  ),
                  SizedBox(width: 14),
                  Container(
                    width: 58,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      'https://www.freepnglogos.com/uploads/youtube-logo-icon-transparent---32.png',
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 40,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      'https://freelogopng.com/images/all_img/1658587303instagram-png.png',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Divider(
      color: Colors.grey, 
      thickness: 0.5,
      height: 0,
    );
  }
}
