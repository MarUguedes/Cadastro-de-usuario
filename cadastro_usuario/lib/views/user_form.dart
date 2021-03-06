// ignore_for_file: prefer_const_constructors

import 'package:cadastro_usuario/models/user.dart';
import 'package:cadastro_usuario/provider/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormdata(User user) {
    if (user != null) {
      _formData['id'] = user.id!;
      _formData['name'] = user.name;
      _formData['number'] = user.number;
      _formData['email'] = user.email;
      _formData['avatar'] = user.urlAvatar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                final isValid = _form.currentState!.validate();
                if (isValid) {
                  _form.currentState!.save();
                  Provider.of<Users>(context, listen: false).put(User(
                    id: _formData['id'],
                    name: _formData['name']!,
                    number: _formData['number']!,
                    email: _formData['email']!,
                    urlAvatar: _formData['urlAvatar']!,
                  ));
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(child:  Padding(
        padding: EdgeInsets.all(10),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _formData['name'],
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um nome válido';
                    }
                    if (value.trim().length < 3) {
                      return ' Mínimo 3 letras';
                    }
                  },
                  onSaved: (value) => _formData['name'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['number'],
                  decoration: InputDecoration(labelText: 'Celular'),
                  onSaved: (value) => _formData['number'] = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um número';
                    }
                    if (value.trim().length < 11) {
                      return 'Número inválido';
                    }
                  },
                ),
                TextFormField(
                  initialValue: _formData['email'],
                  decoration: InputDecoration(labelText: 'E-mail'),
                  onSaved: (value) => _formData['email'] = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um e-mail';
                    }
                  },
                ),
                TextFormField(
                  initialValue: _formData['urlAvatar'],
                  decoration: InputDecoration(labelText: 'URL perfil'),
                  onSaved: (value) => _formData['urlAvatar'] = value!,
                )
              ],
            )),
      ),
      )
    );
  }
}
