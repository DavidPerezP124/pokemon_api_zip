import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/utils/utilities.dart';

///The login component containing text fields and login button
class LoginComponent extends StatelessWidget {
  LoginComponent({Key key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Card(
      child: Container(
        height: _size.height * 0.45,
        width: _size.width * 0.3,
        constraints: BoxConstraints(
            maxHeight: 400, maxWidth: 500, minHeight: 300, minWidth: 200),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _children
                .map((e) => Padding(
                      padding: EdgeInsets.all(20),
                      child: e,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  List<Widget> get _children => [
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
        ButtonBar(
          children: [
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  // Process data.
                }
              },
              child: Text("Login"),
            )
          ],
        )
      ];
}
