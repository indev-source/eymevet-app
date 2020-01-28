import 'dart:ffi';

class Client{

    int id;
    String fullname;
    String phone;
    String address;

    Client({this.id,this.fullname,this.phone,this.address});

    //para insertar los datos en la bd, necesitamos convertirlo en un Map

    Map<String,dynamic> toMap() => {
        "id":id,
        "fullname":fullname,
        "phone":phone,
        "address":address
    };

    //para recibir  losd atos necesitamos pasarlo de Map a json
    factory Client.fromMap(Map<String,dynamic> json) => new Client(
        id:json['id'],
        fullname:json['fullname'],
        phone:json['phone'],
        address:json['address'],
    );
}