import 'package:cadastro_usuario/models/user.dart';
import 'package:cadastro_usuario/provider/user.dart';
import 'package:cadastro_usuario/routes/app.routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.urlAvatar == null || user.urlAvatar.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(
            backgroundImage: NetworkImage(user.urlAvatar),
          );
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.grey,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir usuário'),
                    content: Text('Tem certeza?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Não'),
                        onPressed: () =>
                          Navigator.of(context).pop(false)
                        ,
                      ),
                      FlatButton(
                        child: Text('Sim'),
                        onPressed: () =>
                          Navigator.of(context).pop(true)
                        ,
                      )
                    ],
                  ),
                ).then((confirmed) {
                  if (confirmed) {
                    Provider.of<Users>(context).remove(user);
                  }
                });

                Provider.of<Users>(context, listen: false).remove(user);
              },
            )
          ],
        ),
      ),
    );
  }
}
