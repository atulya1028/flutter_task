import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_task/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isShown = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("images/login.png",width: 250,height: 250,),
                SizedBox(height: 30,),
                //Username
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: "Enter username",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,width: 1)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey,width: 1)
                    )
                  ),
                ),
                SizedBox(height: 15,),
                //Password
                TextField(
                  controller: passwordController,
                  obscureText: isShown,
                  decoration: InputDecoration(
                      hintText: "Enter password",
                      suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        icon: Icon(
                          isShown ? Icons.visibility : Icons.visibility_off,color: Colors.grey,),
                        onPressed: () {
                          setState(() {
                            isShown = !isShown;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey,width: 1)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey,width: 1)
                      )
                  ),
                ),
                SizedBox(height: 15,),
                FlutterPwValidator(width: 400,
                    height: 180,
                    minLength: 7,
                    uppercaseCharCount: 1,
                    specialCharCount: 1,
                    numericCharCount: 1,
                    onSuccess: () {
                  print("Successful");
                    },
                    controller: passwordController),
                SizedBox(height: 30,),
                SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                        ),
                        onPressed: () async {
                          String username = usernameController.text.trim();
                          String password = passwordController.text.trim();
                          QuerySnapshot snap = await FirebaseFirestore.instance.collection("Company")
                              .where('username',isEqualTo: username).get();
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString('username', username);

                          if(username.isEmpty) {
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter username!")));
                          } else if(password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter password!")));
                          }
                          else if(username.length !=10) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Username must be of 10 characters or more")));

                          }
                          else if(password.length != 7) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password must be of 7 characters or more")));
                          }
                          else {
                            try{
                              if(username == snap.docs[0]['username'] && password == snap.docs[0]['password']) {

                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid credentials!")));
                              }
                            }catch (e) {
                              print("Error: "+e.toString());
                            }
                          }
                        }, child: Text("Login")))

              ],
            ),
          ),
        ),
      ),
    );
  }
}
