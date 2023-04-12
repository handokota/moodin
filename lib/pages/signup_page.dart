import 'package:flutter/material.dart';
import 'package:moodin/pages/signin_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                // end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF002B5B),
                  Color(0xFF2F3131),
                ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(183, 183, 183, 1.0),
                                    blurRadius: 10,
                                    offset: Offset(0, 15))
                              ]),
                          child: Column(
                            children: const <Widget>[
                              TextField(
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  labelText: 'Username',
                                  hintText: "Type username",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.call),
                                  labelText: 'Phone Number',
                                  hintText: "Type phone number",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  labelText: 'Email',
                                  hintText: "Type a new Email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.key),
                                  labelText: 'Password',
                                  hintText: "Type a new Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const SignInPage();
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                            // padding: EdgeInsets.all(20),
                            backgroundColor: const Color.fromARGB(255, 0, 43, 91),
                            fixedSize: const Size(300, 50),
                            elevation: 15,
                            shadowColor: const Color.fromARGB(255, 0, 43, 91),
                            textStyle: const TextStyle(fontFamily: "Netflix",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              letterSpacing: 0.0,
                              color: Colors.white,),
                          ),
                          child: const Text("Sign Up"),
                        ),
                        const SizedBox(height: 20,),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const SignInPage();
                            }));
                          },
                          child: const Text("Already have account? Sign In", style: TextStyle(color: Colors.grey,),),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}