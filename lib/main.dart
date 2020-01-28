import 'package:flutter/material.dart';
import 'package:flutter_app/products.dart';
import 'clients.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Listado de productos',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: MyHomePage(title: 'Dashboard'),
        );
    }
}

class MyHomePage extends StatefulWidget {
    MyHomePage({Key key, this.title}) : super(key: key);
    final String title;
    @override
    _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage>{

    @override Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title),
                backgroundColor: Colors.redAccent,
            ),
            backgroundColor: Colors.white24,
            body: Container(
                padding: EdgeInsets.all(30.0),
                child: GridView.count(
                    crossAxisCount: 2,
                    children: <Widget>[
                        Card(
                            margin: EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsApp()));
                                },
                                splashColor: Colors.redAccent,
                                child: Center(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                            Icon(Icons.shopping_basket,size:70.0,color: Colors.redAccent,),
                                            Text("Productos",
                                                style: TextStyle(
                                                    fontSize: 17.0
                                                ),
                                            )
                                        ],
                                    ),
                                ),
                            ),
                        ),
                        Card(
                            margin: EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClientsPage()));
                                },
                                splashColor: Colors.greenAccent,
                                child: Center(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                            Icon(Icons.monetization_on,size:70.0,color: Colors.greenAccent,),
                                            Text("Ventas",
                                                style: TextStyle(
                                                    fontSize: 17.0
                                                ),
                                            )
                                        ],
                                    ),
                                ),
                            ),
                        ),
                        Card(
                            margin: EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClientsPage()));
                                },
                                splashColor: Colors.greenAccent,
                                child: Center(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                            Icon(Icons.shopping_cart,size:70.0,color: Colors.black,),
                                            Text("Vender",
                                                style: TextStyle(
                                                    fontSize: 17.0
                                                ),
                                            )
                                        ],
                                    ),
                                ),
                            ),
                        ),
                        Card(
                            margin: EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClientsPage()));
                                },
                                splashColor: Colors.greenAccent,
                                child: Center(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                            Icon(Icons.people,size:70.0,color: Colors.lightBlue,),
                                            Text("Clientes",
                                                style: TextStyle(
                                                    fontSize: 17.0
                                                ),
                                            )
                                        ],
                                    ),
                                ),
                            ),
                        ),
                        Card(
                            margin: EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClientsPage()));
                                },
                                splashColor: Colors.greenAccent,
                                child: Center(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                            Icon(Icons.refresh,size:70.0,color: Colors.deepOrangeAccent
                                                ,),
                                            Text("Sincronización",
                                                style: TextStyle(
                                                    fontSize: 17.0
                                                ),
                                            )
                                        ],
                                    ),
                                ),
                            ),
                        ),
                        Card(
                            margin: EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClientsPage()));
                                },
                                splashColor: Colors.greenAccent,
                                child: Center(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                            Icon(Icons.apps,size:70.0,color: Colors.lightGreen
                                                ,),
                                            Text("Acerca de",
                                                style: TextStyle(
                                                    fontSize: 17.0
                                                ),
                                            )
                                        ],
                                    ),
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}