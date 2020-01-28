import 'package:flutter/material.dart';

import 'add_edit_client.dart';
import 'db/database.dart';
import 'models/client_model.dart';


void main() =>  runApp(ClientsApp());

class ClientsApp extends StatelessWidget{

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                primarySwatch: Colors.teal,
            ),
            home: ClientsPage(),
        );
    }
}
class ClientsPage extends StatefulWidget{
      @override
      _MyclientPageState createState() => _MyclientPageState();
}
class _MyclientPageState extends State<ClientsPage> {
    @override
    void didUpdateWidget(ClientsPage oldWidget){
        super.didUpdateWidget((oldWidget));
        setState(() {

        });
    }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Listado de clientes"),
                actions: <Widget>[
                    RaisedButton(
                        color:Theme.of(context).primaryColor,
                        onPressed: (){
                            ClientDataBaseProvider.db.deleteAllClients();
                            setState(() {});
                        },
                        child: Text("Delete",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.black
                            ),
                        ),
                    )
                ],
            ),
            body: FutureBuilder<List<Client>>(
                future:ClientDataBaseProvider.db.getAllClients(),
                builder: (BuildContext context,AsyncSnapshot<List<Client>> snapshot){
                    if(snapshot.hasData){
                        return ListView.builder(
                            physics:BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index){
                                Client item = snapshot.data[index];
                                return Dismissible(
                                    key:UniqueKey(),
                                    background: Container(color:Colors.red),
                                    onDismissed: (diretion){
                                        ClientDataBaseProvider.db.deleteClientWithId(item.id);
                                    },
                                    child:ListTile(
                                        title: Text(item.fullname),
                                        subtitle: Text(item.phone),
                                        leading: CircleAvatar(child: Text(item.id.toString()),),
                                        onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => AddEditClient(
                                                    true,
                                                    client:item
                                                )
                                            ));
                                        },
                                    )
                                );
                            },
                        );
                    }else{
                        return Center(child:CircularProgressIndicator());
                    }
                },
            ),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddEditClient(false)));
                },
            ),
        );
    }
}