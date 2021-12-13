import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suiviventes/Models/vehicule.dart';

import '../constants.dart';
class GenererBonGasoil extends StatefulWidget {
  @override
  _GenererBonGasoilState createState() => _GenererBonGasoilState();
}

class _GenererBonGasoilState extends State<GenererBonGasoil> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _getStateList();

  }

  final TextEditingController _kilometrage = TextEditingController();
  final TextEditingController _montant = TextEditingController();
  String _choicePartner='';
  var choicePartner = ['','Partenaire','Autres'];
  final TextEditingController _controller = TextEditingController()..text= "2020/12/11";
  DateTime _date = DateTime(2020, 11, 17);
  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      // _controller.text=newDate as String;
      setState(() {
        _date = newDate;
      });
    }
  }
  List<Vehicule> listVehicules = [];
  Vehicule vehiculeChoisie = Vehicule("","","");
  Vehicule engine = Vehicule("Engins", "", "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generer Bon Gasoil"),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
        future: Vehicule.getVehicules(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          listVehicules = snapshot.data as List<Vehicule>;
          listVehicules.add(engine);
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      suffixIcon:  IconButton(icon: Icon(Icons.calendar_today), onPressed:_selectDate,),
                      labelText: 'Date du bon',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Divider(thickness: 1,),
                  SizedBox(height: 10,),
                  InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      labelText: 'Type',
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                    ),
                    child:DropdownButton<String>(
                      isExpanded: true,
                      value: _choicePartner,
                      icon: const Icon(Icons.arrow_circle_down),
                      iconSize: 20,
                      elevation: 16,
                      underline: Container(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _choicePartner = newValue!;
                          print(_choicePartner);
                        });
                      },
                      items: List.generate(
                        choicePartner.length,
                            (index) => DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                choicePartner[index]
                            ),
                          ),
                          value: choicePartner[index],
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 1,),
                  SizedBox(height: 10,),
                  // InputDecorator(
                  //   decoration: InputDecoration(
                  //     contentPadding: EdgeInsets.symmetric(
                  //         horizontal: 20.0, vertical: 15.0),
                  //     labelText: 'Vehicule',
                  //     border:
                  //     OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  //   ),
                  //   child:DropdownButton<Vehicule>(
                  //     value: vehiculeChoisie,
                  //     iconSize: 30,
                  //     icon: (null),
                  //     style: TextStyle(
                  //       color: Colors.black54,
                  //       fontSize: 16,
                  //     ),
                  //     hint: Text('Select State'),
                  //     onChanged: (Vehicule? newValue) {
                  //       setState(() {
                  //         vehiculeChoisie = newValue!;
                  //         // _getCitiesList();
                  //         print(vehiculeChoisie);
                  //       });
                  //     },
                  //     items: statesList?.map((vehicule) {
                  //       return new DropdownMenuItem<Vehicule>(
                  //         child: new Text(vehicule.nomVehicule + " " + vehicule.immatricule),
                  //         value: vehicule,
                  //       );
                  //     })?.toList() ??
                  //         [],
                  //   ),
                  // ),

                  if(vehiculeChoisie.nomVehicule == "Engins")...[
                    Engines(),
                  ],
                  if(vehiculeChoisie.nomVehicule != "Engins")...[
                    Vehicules(),
                  ],
                  SizedBox(height: 10,),
                  Divider(thickness: 1,),
                  SizedBox(height: 10,),
                  bonImage(),
                  ElevatedButton(onPressed: () {
                    Navigator.pop(context);

                  },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: Text('Generer un bon'),

                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget Engines()=>
      Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 10,),
            TextFormField(
              controller: _kilometrage,
              keyboardType: TextInputType.number,
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                labelText: 'Montant Tracteur 1 (Rouge)',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              onChanged: (String? value){
                print(value);
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _kilometrage,
              keyboardType: TextInputType.number,
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                labelText: 'Montant Tracteur 2 (Vert)',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              onChanged: (String? value){
                print(value);
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _kilometrage,
              keyboardType: TextInputType.number,
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                labelText: 'Montant JCB',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              onChanged: (String? value){
                print(value);
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _kilometrage,
              keyboardType: TextInputType.number,
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                labelText: 'Montant Groupe',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              onChanged: (String? value){
                print(value);
              },
            ),
          ],

        ),
      );


  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

Widget bonImage(){
  return Stack(
    children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/images/gasoline.png") : FileImage(File(_imageFile!.path)) as ImageProvider ,
        ),
      Positioned(child: InkWell(
        onTap: (){
          showModalBottomSheet(
            context: context,
            builder: ((builder) => bottomSheet()),
          );
        },
        child: Icon(
          Icons.camera_alt,
        ),
      ))
    ],
  );
}
  Widget Vehicules()=>
  Container(
    child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        SizedBox(height: 10,),
        Divider(thickness: 1,),
        SizedBox(height: 10,),
        TextFormField(
          controller: _kilometrage,
          keyboardType: TextInputType.number,
          decoration:  InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 15.0),
            labelText: 'Kilometrage',
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          onChanged: (String? value){
            print(value);
          },
        ),
        SizedBox(height: 10,),
        Divider(thickness: 1,),
        SizedBox(height: 10,),
        TextFormField(
          controller: _montant,
          keyboardType: TextInputType.number,
          decoration:  InputDecoration(
            hintText: "100 DH",
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 15.0),
            labelText: 'Montant',
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          onChanged: (String? value){
            print(value);
          },
        ),
      ],
    ),
  );
  // @override
  // void initState() {
  //   _future = Vehicule.getVehicules();
  //   super.initState();
  // }

// -------------------------------------

  List? statesList;
  String? _myState;

  Future<List<Vehicule>> _getStateList() async {
    List<Vehicule> listMapped;
    final url = Uri.parse('http://$urlApi:3000/vehicules');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List vehicules = json.decode(response.body);
      listMapped =  vehicules.map((json) => Vehicule.fromJson(json)).toList();
      setState(() {
        statesList = listMapped;
        vehiculeChoisie=listMapped[0];
        print(vehiculeChoisie);
      });
      return listMapped;
    } else {
      throw Exception();
    }
  }

}
