import 'package:flutter/material.dart';
import 'package:markazapp/itemsmodel.dart';

class RecommendedPlacrorderScreen extends StatefulWidget {
  final Items recommendedplaceorderdata;
  const RecommendedPlacrorderScreen({super.key,required this.recommendedplaceorderdata});

  @override
  State<RecommendedPlacrorderScreen> createState() => _RecommendedPlacrorderScreenState();
}

class _RecommendedPlacrorderScreenState extends State<RecommendedPlacrorderScreen> {
  int quantity = 1;
 
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
    int price = widget.recommendedplaceorderdata.rupees!*quantity;
     int disc = widget.recommendedplaceorderdata.deliverycharges!;
     int z = price+disc;
    return Scaffold(
      appBar: AppBar(
        title: Text("Place Order"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Size:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(width: 4),
                  Container(
                    width: 100,
                    height: 29,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.green,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${widget.recommendedplaceorderdata.productSize}",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(color: Colors.grey), // Grey line before Quantity row
            ),
            Row(
              children: [
                SizedBox(width: 10),
                Text("Quantity:", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
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
              child: Divider(color: Colors.grey), // Grey line after Quantity row
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Profit',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Wholesale Price", style: TextStyle(fontSize: 12)),
                ),
                SizedBox(width: 190),
                Text("${price}", style: TextStyle(fontSize: 12)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Delivery Charges", style: TextStyle(fontSize: 12)),
                ),
                SizedBox(width: 190),
                Text("${widget.recommendedplaceorderdata.deliverycharges}", style: TextStyle(fontSize: 12)),
                
              ],
            ),
             Text("Customer ki price=$z")
          ],
        ),
      ),
    );

  }
}