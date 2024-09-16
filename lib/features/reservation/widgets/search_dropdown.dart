import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:barber_shop/repositories/auth_repo.dart';
import 'package:flutter/material.dart';

class SearchDropdown extends StatefulWidget {
  const SearchDropdown({Key? key}) : super(key: key);

  @override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  final _formKey = GlobalKey<FormState>();

  AuthRepo _authRepo = AuthRepo();
  List<String> _userNames = [];
  String? selectedItem;
  TextEditingController numController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserNames();
  }

  Future<void> _fetchUserNames() async {
    final users = await _authRepo.getAllClients();
    setState(() {
      _userNames = users.map((user) => user['phone'] as String).toList();
      selectedItem = _userNames.isNotEmpty ? _userNames[0] : null;
    });
  }

  Future<void> _handleAddClient() async {
    String phone = numController.text.trim();
    if (phone.isNotEmpty && !_userNames.contains(phone)) {
      bool result = await _authRepo.getClientOrCreate(phone);
      if (result) {
        _fetchUserNames();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Client added successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Client already exists!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid phone number')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              // TextField for entering phone number
              Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 8 ||
                              value.length > 8) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                        controller: numController,
                        decoration: InputDecoration(
                          labelText: 'Enter phone number',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _handleAddClient();
                      }
                    },
                    color: const Color.fromARGB(255, 7, 69, 255),
                    icon: Icon(Icons.add),
                  )
                ],
              ),
              SizedBox(height: 8),
              // CustomDropdown for selecting existing users
              CustomDropdown<String>.search(
                hintText: 'Select a user',
                items: _userNames,
                initialItem: selectedItem,
                overlayHeight: 342,
                onChanged: (value) {
                  log('SearchDropdown onChanged value: $value');
                  setState(() {
                    selectedItem = value;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
