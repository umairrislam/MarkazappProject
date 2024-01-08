import 'package:flutter/material.dart';

class OrderScreenNavBar extends StatefulWidget {
 
  const OrderScreenNavBar({super.key,required });

  @override
  State<OrderScreenNavBar> createState() => _PostOrderScreenState();
}

class _PostOrderScreenState extends State<OrderScreenNavBar> {
   int quantity = 1;
   int rupees=300;
   int charges=123;

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
     int price = rupees* quantity;
    int disc =charges;
    int z = price + disc;
    return Scaffold(
      appBar: AppBar(
        title: Text("Place Order"),
      ),
      body: SafeArea(
        child: Card(
          
          child: Container(
            height: 300,
            child: Column(
              children: [
              
                SizedBox(height: 10),
                
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child:
                      Divider(color: Colors.grey), // Grey line before Quantity row
                ),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Text("Quantity:",
                        style:
                            TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    SizedBox(width: 190),
                    GestureDetector(
                      onTap: decrement,
                      child: Icon(Icons.remove),
                    ),
                    SizedBox(width: 10),
                    Text("$quantity"),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: increment,
                      child: Icon(Icons.add),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child:
                      Divider(color: Colors.grey), // Grey line after Quantity row
                ),
              
                SizedBox(height: 10),
               
              ],
            ),
          ),
        ),
        
      ),
       bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                
                child: Container(
                  width: 100,
                  height: 45,
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Your Order',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: 110,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                 
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 2 ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Total Amount:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                                  
                                  color: Colors.black,
                                ),
                              ),
                            ),
                             Padding(
                               padding: const EdgeInsets.all(2.0),
                               child: Text(
                                '100',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                                                               ),
                             ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    'Subtotal:',
                                    style: TextStyle(
                                       fontSize: 12,
                                          fontWeight: FontWeight.w500,
                  
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                 Padding(
                               padding: const EdgeInsets.all(2.0),
                               child: Text(
                                '$z',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                                                               ),
                             ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.all(2.0),
                 child: Container(
                   width: 100,
                   height: 45,
                   decoration: BoxDecoration(
                     color: Colors.orange,
                     borderRadius: BorderRadius.circular(10.0),
                      // Set the border color to black
                     ),
                   
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                      
                       SizedBox(width: 8),
                       Text(
                         'Checkout',
                         style: TextStyle(
                           fontSize: 12,
                           color: Colors.black,
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
              
            ],
          ),
        ),
      ),
    );
  }
}