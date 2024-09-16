import 'package:barber_shop/repositories/service_repo.dart';
import 'package:flutter/material.dart';

class ChipWidget extends StatefulWidget {
  final Function(double) onTotalPriceChanged;

  ChipWidget({super.key, required this.onTotalPriceChanged});

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  List<String> services_name = [];
  List<String> selectedServices = [];
  double totalPrice = 0.0;
  final ServiceRepo _serviceRepo = ServiceRepo();

  @override
  void initState() {
    super.initState();
    _getAllServices();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      children: services_name
          .map((service) => Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                label: Text(service),
                deleteIcon: Icon(Icons.add),
                backgroundColor: selectedServices.contains(service)
                    ? Color.fromARGB(255, 104, 132, 243)
                    : null,
                onDeleted: () async {
                  double servicePrice =
                      await _serviceRepo.getServiceByPrice(service);
                  setState(() {
                    if (selectedServices.contains(service)) {
                      selectedServices.remove(service);
                      totalPrice -= servicePrice;
                    } else {
                      selectedServices.add(service);
                      totalPrice += servicePrice;
                    }
                    totalPrice = totalPrice.toDouble();
                    print(totalPrice);
                    widget.onTotalPriceChanged(totalPrice);
                  });
                },
              ))
          .toList(),
    );
  }

  Future<void> _getAllServices() async {
    final services = await _serviceRepo.getAllServices();
    setState(() {
      services_name = services.map((e) => e.name).toList();
    });
  }
}
