import 'package:flutter/material.dart';
import 'package:flutter_app/db/database_products.dart';
import 'package:flutter_app/models/product_model.dart';



void main() =>  runApp(ProductsApp());

class ProductsApp extends StatelessWidget{

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                primarySwatch: Colors.teal,
            ),
            home: ProductsPage(),
        );
    }

}

class ProductsPage extends StatefulWidget{
    @override
    _MyclientPageState createState() => _MyclientPageState();

}

class _MyclientPageState extends State<ProductsPage> {
    @override
    void didUpdateWidget(ProductsPage oldWidget){
        super.didUpdateWidget((oldWidget));
        setState(() {

        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Listado de productos"),
                actions: <Widget>[
                    RaisedButton(
                        color:Theme.of(context).primaryColor,
                        onPressed: (){
                            ProductDatabaseProvider.db.deleteAllProducts();
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
            body: FutureBuilder<List<Product>>(
                future:ProductDatabaseProvider.db.getallProducts(),
                builder: (BuildContext context,AsyncSnapshot<List<Product>> snapshot){
                    if(snapshot.hasData){
                        return ListView.builder(
                            physics:BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index){
                                Product item = snapshot.data[index];
                                return Dismissible(
                                    key:UniqueKey(),
                                    background: Container(color:Colors.red),
                                    onDismissed: (diretion){
                                        ProductDatabaseProvider.db.deleteProductWithId(item.id);
                                    },
                                    child:ListTile(
                                        title: Text(item.name),
                                        subtitle: Text(item.marca),
                                        leading: CircleAvatar(child: Text(item.id.toString()),),
                                        onTap: (){

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

                },
            ),
        );
    }

}