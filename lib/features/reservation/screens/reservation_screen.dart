import 'package:barber_shop/features/reservation/widgets/chip_widget.dart';
import 'package:barber_shop/features/reservation/widgets/search_dropdown.dart';
import 'package:barber_shop/features/reservation/widgets/avatar_widget.dart';
import 'package:barber_shop/features/reservation/widgets/calendar_widget.dart';
import 'package:barber_shop/screens/drawer_widget.dart';
import 'package:flutter/material.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  double totalPrice = 0.0;

  void onTotalPriceChanged(double newTotalPrice) {
    setState(() {
      totalPrice = newTotalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AvatarWidget(),
            const SizedBox(height: 15),
            const Row(
              children: [
                Text("Client: "),
                SizedBox(width: 25),
                Expanded(child: SearchDropdown()),
              ],
            ),
            const SizedBox(height: 15),
            ChipWidget(onTotalPriceChanged: onTotalPriceChanged),
            const SizedBox(height: 15),
            Text(
              "Total: \$${totalPrice.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Expanded(
              child: TableCalendarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
