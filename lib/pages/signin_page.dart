import 'package:flutter/material.dart';
import 'package:moodin/pages/home_page.dart';
import 'package:moodin/pages/signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                  // Text(
                  //   "Hallo Guys!",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.w100),
                  // )
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
                              color: const Color.fromARGB(255, 255, 255, 255),
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
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  labelText: 'Email',
                                  hintText: "Type Email",
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
                                  hintText: "Type Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  labelText: 'Password',
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
                              return Navigation();
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                            // padding: EdgeInsets.all(20),
                            backgroundColor: const Color.fromARGB(
                                255, 0, 43, 91),
                            fixedSize: const Size(300, 50),
                            elevation: 15,
                            shadowColor: const Color.fromARGB(255, 0, 43, 91),
                            textStyle: const TextStyle(fontFamily: "Netflix",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              letterSpacing: 0.0,
                              color: Colors.white,),
                          ),
                          child: const Text("Sign In"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const SignUpPage();
                            }));
                          },
                          child: const Text(
                            "Don't have account? Sign Up",
                            style: TextStyle(color: Colors.grey),
                          ),
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