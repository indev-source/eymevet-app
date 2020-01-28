import 'package:flutter/material.dart';
import 'package:flutter_app/models/client_model.dart';
import 'package:flutter_app/db/database.dart';

class AddEditClient extends StatefulWidget{

    final bool edit;
    final Client client;

    AddEditClient(this.edit,{this.client})
    : assert(edit == true || client == null);

    @override
    _AddEditClientState createState() => _AddEditClientState();
}

class _AddEditClientState extends State<AddEditClient> {

    TextEditingController fullnameEditingController  = TextEditingController();
    TextEditingController phoneEditingController     = TextEditingController();
    TextEditingController addressEditingController   = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    @override
    void initState(){
        if(widget.edit == true){
            fullnameEditingController.text = widget.client.fullname;
            phoneEditingController.text    = widget.client.phone;
            addressEditingController.text  = widget.client.address;
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title:Text(widget.edit?"Editar cliente":"Agregar Cliente"),),
            body:Form(
                key:_formKey,
                child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:SingleChildScrollView(
                        child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                textFormField(
                                    fullnameEditingController,
                                    "Nombre completo",
                                    "Ingresa el nombre completo del cliente",
                                    Icons.person,
                                    widget.edit ? widget.client.fullname : 'fullname'
                                ),
                                textFormField(
                                    phoneEditingController,
                                    "Telefono",
                                    "Ingresa el numero telefonico del cliente",
                                    Icons.phone,
                                    widget.edit ? widget.client.phone : 'phone'
                                ),
                                textFormField(
                                    addressEditingController,
                                    "Direccion",
                                    "Ingresa la dirección del cliente",
                                    Icons.bookmark,
                                    widget.edit ? widget.client.address : 'address'
                                ),
                                RaisedButton(
                                    color:Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:BorderRadius.circular(10)
                                    ),
                                    child: Text(widget.edit?"Actualizar":"Agregar",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            color:Colors.white
                                        ),
                                    ),
                                    onPressed: ()async{
                                        if(!_formKey.currentState.validate()){
                                            Scaffold.of(context).showSnackBar(
                                                SnackBar(content: Text("Procesando datos"),)
                                            );
                                        }else if(widget.edit == true){
                                            ClientDataBaseProvider.db.updateClient(new Client(
                                                fullname:fullnameEditingController.text,
                                                phone:phoneEditingController.text,
                                                id: widget.client.id,
                                                address: addressEditingController.text
                                            ));
                                            Navigator.pop(context);
                                        }else{
                                            await ClientDataBaseProvider.db.addClientToDatabase(new Client(
                                                fullname:fullnameEditingController.text,
                                                phone:phoneEditingController.text,
                                                address: addressEditingController.text
                                            ));
                                            Navigator.pop(context);
                                        }
                                    },
                                )
                            ],
                        )
                    )
                )
            )
        );
    }

    textFormField(TextEditingController field, String label , String hint, IconData iconData, String initialValue){
        return Padding(
            padding: const EdgeInsets.only(top:10),
            child: TextFormField(
                validator: (value){
                    if(value.isEmpty){
                        return 'Porfavor ingresa los datos correspientes';
                    }
                },
                controller: field,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    prefixIcon: Icon(iconData),
                    hintText: label,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
            ),
        );
    }
}