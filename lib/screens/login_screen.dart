import 'package:barber_shop/repositories/auth_repo.dart';
import 'package:barber_shop/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var visiblePassword = false;
  @override
  Widget build(BuildContext context) {
    void changeVisibility() {
      setState(() {
        visiblePassword = !visiblePassword;
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 100, 90, 235),
                Color.fromARGB(255, 48, 55, 158)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: Text(
              'Login Page',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Image.asset(
                "images/login.png",
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.email)),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !isValidEmail(value)) {
                    return "Invalid email";
                  } else {
                    return null;
                  }
                },
                controller: emailController,
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      visiblePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: changeVisibility,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  labelText: "Password",
                  hintText: "****",
                ),
                controller: passwordController,
                obscureText: !visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 8) {
                    return "password invalid";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // login logic here
                    User? user = await AuthRepo()
                        .Login(emailController.text, passwordController.text);
                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Invalid Credential"),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  //foregroundColor: Colors.amber,
                  backgroundColor: Color.fromARGB(255, 32, 45, 183),
                  padding: EdgeInsets.symmetric(
                      vertical: 15), // Adjust vertical padding if needed
                ),
                child: SizedBox(
                  width: double.infinity, // Set the width here
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {},
                      child: Text(
                        "oublier mot de passe?",
                        style:
                            TextStyle(color: Color.fromARGB(255, 203, 45, 28)),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegExp.hasMatch(email);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
