import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:markazapp/Models/addtocart_model.dart';

import 'package:markazapp/Screens/i10n.dart';
import 'package:markazapp/Signinsignupscreens/splashscreen.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:markazapp/provider/Latestproduct_provider.dart';
import 'package:markazapp/provider/categories_provider.dart';
import 'package:markazapp/provider/checkout_provider.dart';
import 'package:markazapp/provider/featured_provider.dart';
import 'package:markazapp/provider/listoforder_provider.dart';
import 'package:markazapp/provider/product_provider.dart';
import 'package:markazapp/provider/product_variationsprovider.dart';
import 'package:markazapp/provider/update_provider.dart';
import 'package:provider/provider.dart';


void main(){
   runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
      create: (context) => CategoriesProvider(),
      
      ),
       ChangeNotifierProvider(
      create: (context) => Productprovider(),
      
      ),
      ChangeNotifierProvider(
      create: (context) => LatestProductProvider(),
      
      ),
       ChangeNotifierProvider(
      create: (context) => FeaturedProvider(),
      
      ),
       ChangeNotifierProvider(
      create: (context) => CartNotifier(),
     
       ),
        ChangeNotifierProvider(
      create: (context) => checkOutProvider(),
     
       ),
        ChangeNotifierProvider(
      create: (context) => listOfOrderProvider(),
     
       ),
       ChangeNotifierProvider(
      create: (context) => LatestProductProvider()
     
       ),
        ChangeNotifierProvider(
      create: (context) => singleProductVariationProvider()
     
       ),
       ChangeNotifierProvider(
      create: (context) => UpdateProvider()
     
       ),

    ],
    child: MyWidget(),
    )
    
    
     );
}
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: EasyLoading.init(),
      home: SplashScreen(),
      
    );
  }
}