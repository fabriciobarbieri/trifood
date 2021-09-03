import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entra"),
        centerTitle: true,
      ),

      body: Form(
          child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          SizedBox(height: 200.0,),
          TextFormField(
            decoration: InputDecoration(hintText: "E-mail"),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16.0,),

          TextFormField(
            decoration: InputDecoration(hintText: "Senha"),
          ),
          SizedBox(height: 16.0,),
          OutlineButton(
            shape: StadiumBorder(),
            textColor: Colors.green,
            child: Text('Entra'),
            borderSide: BorderSide(
                color: Colors.green, style: BorderStyle.solid, width: 1),
            onPressed: () {},
          ),
        ],
      )),
    );
  }
}
