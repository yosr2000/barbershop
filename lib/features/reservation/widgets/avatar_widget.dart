import 'package:barber_shop/models/employe.dart';
import 'package:barber_shop/repositories/employe_repo.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({super.key});

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  initState() {
    super.initState();
    getemployees();
  }

  Future<void> getemployees() async {
    final employees = await EmployeRepo().getAllEmployees();
    setState(() {
      emp = employees;
    });
  }

  Color borderColor = Colors.transparent;
  String? selectedEmployee;

  void changerCouleur(String name) {
    setState(() {
      selectedEmployee = selectedEmployee == name ? null : name;
    });
  }

  List<Employee> emp = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: emp.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Container(
            width: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    changerCouleur(emp[index].name);
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("images/login.png"),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedEmployee == emp[index].name
                              ? Color.fromARGB(255, 78, 239, 9)
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  emp[index].name,
                  style: TextStyle(color: const Color.fromARGB(255, 8, 4, 4)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
