import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newprjoect/home_screen/home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  bool isLoding = false;
  final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%^&*])[A-Za-z\d!@#\$%^&*]{8,}$',
  );
  Future singup() async {
    try {
      setState(() {
        isLoding = true;
      });
      final credenti = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailcontroller.text.trim(),
            password: passwordcontroller.text.trim(),
          );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Successful")));
      Get.to(HomeScreen());
    } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      setState(() {
        isLoding=false;
      });
    }
  }



  bool isture = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yes done"),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.amber,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter you email";
                  } else if (!emailRegExp.hasMatch(value)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
                controller: emailcontroller,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.email, color: Colors.red),
                  hintText: "Enter you Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter the password";
                  } else if (!passwordRegExp.hasMatch(value)) {
                    return "Password must be at least 8 characters, include upper & lower case, number & special character";
                  }
                  return null;
                },
                controller: passwordcontroller,
                obscureText: isture,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isture = !isture;
                      });
                    },
                    icon: Icon(
                      isture ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),

                  hintText: "Enter you Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              SizedBox(height: 20),

              isLoding
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                        singup();
                        Get.to(HomeScreen());
                        // if (_formKey.currentState!.validate()) {
                        //   Get.to(HomeScreen());
                        //
                        // }
                      },
                      child: Text("Login"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
