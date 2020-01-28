import 'dart:ffi';

class Product{

    int id;
    String name;
    Float price1;
    Float price2;
    Float price3;
    String marca;

    Product({this.id,this.name,this.price1,this.price2,this.price3,this.marca});

    //para insertar los datos en la bd, necesitamos convertirlo en un Map

    Map<String,dynamic> toMap() => {
        "id":id,
        "name":name,
        "price1":price1,
        "price2":price2,
        "price3":price3,
        "marca":marca
    };

    //para recibir  losd atos necesitamos pasarlo de Map a json
    factory Product.fromMap(Map<String,dynamic> json) => new Product(
        id:json['id'],
        name:json['name'],
        price1:json['price1'],
        price2:json['price2'],
        price3:json['price3'],
        marca:json['marca']
    );
}