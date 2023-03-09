import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../service/pref_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey[200]),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: InputBorder.none,
                  icon: Icon(Icons.email, color: Colors.blue,)
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey[200]),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                    icon: Icon(Icons.lock, color: Colors.blue,)
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blue),
              child: ElevatedButton(
                onPressed: () async {
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();
                  User user = User(email: email, password: password, id: '123');
                  Prefs.storeUser(user);
                  // Prefs.storeName(emailController.text);
                  // print(await Prefs.loadName() );
                  setState(() {});
                },
                child: Text('Login',style: TextStyle(color: Colors.white),),
              )
            ),
            SizedBox(height: 40,),
            FutureBuilder(
              //future: Prefs.loadName(),
              future: Prefs.loadUser(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return Column(
                      children: [
                        Text(snapshot.data!.email),
                        Text(snapshot.data!.password),
                        Text(snapshot.data!.id),
                      ],
                    );
                  } else {
                    return Text('No data');
                  }
                }
              ),
          ],
        ),
      ),
    );
  }
}
