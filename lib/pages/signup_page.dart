import 'package:flutter/material.dart';
import 'package:moodin/pages/signin_page.dart';
import 'package:moodin/firebase_options.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _controllerUsername;
  late TextEditingController _controllerPhoneNumber;
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPassword;

  @override
  void initState(){
    initFirebase();
    _controllerUsername = TextEditingController();
    _controllerPhoneNumber = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                // end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF000000),
                  Color(0xFF000000),
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
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
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
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFdbdcdf), width: 1),
                          ),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: _controllerUsername,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  labelText: 'Username',
                                  hintText: "Type username",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _controllerPhoneNumber,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.call),
                                  labelText: 'Phone Number',
                                  hintText: "Type phone number",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _controllerEmail,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
                                  labelText: 'Email',
                                  hintText: "Type a new Email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: _controllerPassword,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.key),
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
                          child: Text("Sign Up"),
                          onPressed: ()async {
                            final Map<String, dynamic> data = {
                              'username' : _controllerUsername.text,
                              'phoneNumber' : _controllerPhoneNumber.text,
                              'password' : _controllerPassword.text,
                              'email' : _controllerEmail.text
                            };
                            //untuk menambahkan data ke database
                            await db.collection('users').add(data).then((value) => {});

                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return SignInPage();
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                            // padding: EdgeInsets.all(20), backgroundColor: Color.fromARGB(255, 186, 71, 0),
                            fixedSize: Size(300, 50),
                            elevation: 15,
                            // shadowColor: Color.fromARGB(255, 186, 71, 0),
                            textStyle: TextStyle(fontFamily: "Netflix",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              letterSpacing: 0.0,
                              color: Colors.white,),
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return SignInPage();
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