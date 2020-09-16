import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/providers/userStatusProvider.dart';
import 'package:pokemon_api_zip/utils/utilities.dart';
import 'package:provider/provider.dart';

///The login component containing text fields and login button
class LoginComponent extends StatelessWidget {
  LoginComponent({Key key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Consumer<UserStatus>(builder: (context, data, child) {
      return Center(
        child: SingleChildScrollView(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Container(
              height: _size.height * 0.70,
              width: _size.width * 0.3,
              constraints: BoxConstraints(
                  maxHeight: 700, maxWidth: 600, minHeight: 600, minWidth: 300),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ..._children
                          .map((e) => Padding(
                                padding: EdgeInsets.all(20),
                                child: e,
                              ))
                          .toList(),
                      ButtonBar(
                        children: [
                          RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                data.signIn(_nameController.text,
                                    _passwordController.text);
                              }
                            },
                            child: Text("Login"),
                          )
                        ],
                      )
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }

  List<Widget> get _children => [
        Image.asset('assets/images/pokedeex.png'),
        TextFormField(
          controller: _nameController,
          validator: Utilities.nameValidator,
          decoration: InputDecoration(hintText: "username"),
        ),
        TextFormField(
          controller: _passwordController,
          validator: Utilities.passwordValidator,
          decoration: InputDecoration(hintText: "password"),
        ),
      ];
}
