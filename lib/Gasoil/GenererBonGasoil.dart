import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suiviventes/Models/Bons.dart';
import 'package:suiviventes/Models/Engins.dart';
import 'package:suiviventes/Models/PDFApi.dart';
import 'package:suiviventes/Models/vehicule.dart';
import 'package:path/path.dart' as path;

import '../constants.dart';
import 'GetBonGenere.dart';
String? pdfURL;
class GenererBonGasoil extends StatefulWidget {

  static void pdfSetUrl(String url){
    pdfURL = url;
  }
  @override
  _GenererBonGasoilState createState() => _GenererBonGasoilState();
}

class _GenererBonGasoilState extends State<GenererBonGasoil> {
  String typeChoisi = "";
  int numberOfEngins = 0;
  bool isLoading = false;
  Position? _position;
  StreamSubscription<Position>? _streamSubscription;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _importJustif = TextEditingController()
    ..text = "Aucun fichier choisi";
  final TextEditingController _positionController = TextEditingController()
    ..text = "Aucune location detectee";
  final TextEditingController _kilometrage = TextEditingController();
  final TextEditingController _montant = TextEditingController();
  final List<TextEditingController> _enginsController = List.generate(
      5, (i) => TextEditingController());
  String _choicePartner = '';
  var choicePartner = ['', 'Partenaire', 'Autres'];
  final TextEditingController _controller = TextEditingController()
    ..text = "2020/12/11";
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
  List<Engins> listEnginsData = [];
  Vehicule vehiculeChoisie = Vehicule("", "", "");
  Vehicule engine = Vehicule("Engins", "", "");

  @override
  void initState() {
    super.initState();
    _getStateList();
    _getEnginsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generer Bon Carburant"),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
        future: Vehicule.getVehicules(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          listVehicules = snapshot.data as List<Vehicule>;
          listVehicules.add(engine);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(icon: Icon(Icons.calendar_today),
                      onPressed: _selectDate,),
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
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  child: DropdownButton<String>(
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
                          (index) =>
                          DropdownMenuItem(
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
                InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    labelText: 'Vehicule',
                    border:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  child: DropdownButton<Vehicule>(
                    value: vehiculeChoisie,
                    iconSize: 30,
                    icon: (null),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint: Text('Select State'),
                    onChanged: (Vehicule? newValue) {
                      setState(() {
                        vehiculeChoisie = newValue!;
                        // _getCitiesList();
                        print(vehiculeChoisie);
                      });
                    },
                    items: statesList?.map((vehicule) {
                      return new DropdownMenuItem<Vehicule>(
                        child: new Text(
                            vehicule.nomVehicule + " " + vehicule.immatricule),
                        value: vehicule,
                      );
                    })?.toList() ??
                        [],
                  ),
                ),

                if(vehiculeChoisie.nomVehicule == "Engins")...[
                  // Engines(),
                  EnginsBuilder()
                ],
                if(vehiculeChoisie.nomVehicule != "Engins")...[
                  Vehicules(),
                ],
                if(_choicePartner == "Autres") ...[
                  SizedBox(height: 10,),
                  Divider(thickness: 1,),
                  SizedBox(height: 10,),
                  bonImage(),
                  SizedBox(height: 10,),
                  Divider(thickness: 1,),
                  SizedBox(height: 10,),
                  getLocationWidget(),
                ],
                ElevatedButton(onPressed: () async {
                  if (vehiculeChoisie.nomVehicule == "Engins" &&
                      _choicePartner == "Partenaire") {
                    print("ENGINS PARTENAIRE");
                    await createBonEnginPartenaire();

                  }
                  if (vehiculeChoisie.nomVehicule != "Engins" &&
                      _choicePartner == "Partenaire") {
                    print("VOITURE PARTENAIRE");

                    await createBonVehiculePartenaire();
                  }
                  if (vehiculeChoisie.nomVehicule != "Engins" &&
                      _choicePartner == "Autres") {
                    print("VOITURE AUTRES");

                    await createBonVehiculeAutres();
                  }
                  if (vehiculeChoisie.nomVehicule == "Engins" &&
                      _choicePartner == "Autres") {
                    print("Engins AUTRES");

                    await createBonEnginsAutres();
                  }

                  // final url =
                  //     'http://$urlApi:3000/bons/pdf/DUSTER2020-11-17.pdf';

                  final url = Bons.getPdfUrl();
                  final file = await PDFApi.loadNetwork(pdfURL!);
                  openPDF(context, file);
                },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.red),
                  ),
                  child: Text('Generer un bon'),

                ),
              ],
            ),
          );
        },
      ),
    );
  }

  FutureBuilder<List<Engins>> EnginsBuilder() {
    return FutureBuilder(
        future: _getEnginsList(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          listEnginsData = snapshot.data! as List<Engins>;
          numberOfEngins = snapshot.data!.length;
          // listVehicules = snapshot.data as List<Engins>;
          // listVehicules.add(engine);
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  Divider(thickness: 1,),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _enginsController[i],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      labelText: snapshot.data![i].nom,
                      border:
                      OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    onChanged: (String? value) {

                    },
                  ),
                ],
              );
            },

          );
        }
    );
  }

//================================================


  Future<String> createBonEnginPartenaire() async {
    List<Engins> listEngins = [];
    for (int i = 0; i < numberOfEngins; i++) {
      if (listEnginsData[i] != null && _enginsController[i] != null) {
        listEnginsData[i].montant = _enginsController[i].text;
        // _montant.text = ((int.parse(_montant.text)) + (int.parse(listEnginsData[i].montant))).toString() ;
        listEngins.add(listEnginsData[i]);
      }
    }
    Bons bon = new Bons.partEngins(
        "${_date.toLocal()}".split(' ')[0], _choicePartner, listEngins,
        _montant.text);
    print(bon);
    final result = await bon.createBon(bon);
    final title = 'Done';
    final text = result.error ? (result.errorMessage) : 'Votre Bon a été crée';

    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
    )
        .then((data) {
      if (result.data) {
        Navigator.of(context).pop();
      }
    });
    return "";
  }


  //================================================

  Future<String> createBonVehiculePartenaire() async {
    Bons bon = new Bons.partVehicule(
        "${_date.toLocal()}".split(' ')[0], _choicePartner, vehiculeChoisie,
        _kilometrage.text, _montant.text);
    final result = await bon.createBon(bon);
    final title = 'Done';
    final text = result.error ? (result.errorMessage) : 'Votre Bon a été crée';

    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
    )
        .then((data) {
      if (result.data) {
        Navigator.of(context).pop();
      }
    });

    return "";
  }

//================================================
  Future<String> createBonEnginsAutres() async {
    List<Engins> listEngins = [];
    for (int i = 0; i < numberOfEngins; i++) {
      if (listEnginsData[i] != null && _enginsController[i] != null) {
        listEnginsData[i].montant = _enginsController[i].text;
        // _montant.text = ((int.parse(_montant.text)) + (int.parse(listEnginsData[i].montant))).toString() ;
        listEngins.add(listEnginsData[i]);
      }
    }
    String? imageResponse;
    if (_imageFile!.path != null) {
      imageResponse = await uploadImage(
          _imageFile!.path, "hhhh");
      print(imageResponse);
    };

    Bons bon = Bons.autresEngins(
        "${_date.toLocal()}".split(' ')[0], _choicePartner, listEngins,
        _importJustif.text, _positionController.text, _montant.text);
    final result = await bon.createBon(bon);
    final title = 'Done';
    final text = result.error ? (result.errorMessage) : 'Votre Bon a été crée';

    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
    )
        .then((data) {
      if (result.data) {
        Navigator.of(context).pop();
      }
    });
    return "";
  }

//================================================

  Future<String> uploadImage(filename, url) async {
    print("send image");
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://$urlApi:3000/vehicules/image/"));
    request.files.add(await http.MultipartFile.fromPath('image', filename));
    var res = await request.send();
    // var response = await http.Response.fromStream(res);
    var responseString = await res.stream.bytesToString();
    var imageName = json.decode(responseString);
    _importJustif.text = imageName.map((m) => m['filename']).toString()
        .replaceAll("(", "")
        .replaceAll(")", "");
    return res.reasonPhrase!;
  }


//================================================

  Future<String> createBonVehiculeAutres() async {
    String? imageResponse;
    if (_imageFile!.path != null) {
      imageResponse = await uploadImage(
          _imageFile!.path, "hhhh");
      print(imageResponse);
    };

    Bons bon = Bons.autresVehicule(
        "${_date.toLocal()}".split(' ')[0],
        _choicePartner,
        vehiculeChoisie,
        _kilometrage.text,
        _importJustif.text,
        _positionController.text,
        _montant.text);

    final result = await bon.createBon(bon);
    final title = 'Done';
    final text = result.error ? (result.errorMessage) : 'Votre Bon a été crée';

    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
    )
        .then((data) {
      if (result.data) {
        Navigator.of(context).pop();
      }
    });
    return "";
  }


  //================================================

  Widget Engines() =>
      Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 10,),
            TextFormField(
              controller: _kilometrage,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                labelText: 'Montant Tracteur 1 (Rouge)',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              onChanged: (String? value) {
                print(value);
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _kilometrage,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                labelText: 'Montant Tracteur 2 (Vert)',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              onChanged: (String? value) {
                print(value);
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _kilometrage,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                labelText: 'Montant JCB',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              onChanged: (String? value) {
                print(value);
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _kilometrage,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                labelText: 'Montant Groupe',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              onChanged: (String? value) {
                print(value);
              },
            ),
          ],

        ),
      );

//================================================

  Widget getLocationWidget() {
    return Stack(
      children: <Widget>[
        TextFormField(
          controller: _positionController,
          enabled: false,
          showCursor: true,
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 15.0),
            labelText: '        Get location',
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        !isLoading ? Positioned(
            top: 11,
            child: InkWell(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                Position position = await Vehicule
                    .determinePosition() as Position;
                List<Placemark> placemarks = await placemarkFromCoordinates(
                    position.latitude, position.longitude);
                print(placemarks);
                setState(() {
                  _positionController.text = placemarks[0].street! + ", " +
                      placemarks[0].subLocality! + ", " +
                      placemarks[0].locality! + ", " + placemarks[0].country! +
                      placemarks[0].postalCode! + ", ";
                  isLoading = false;
                });
              },
              child: Icon(
                Icons.camera_alt,
              ),
            )) : Center(child: CircularProgressIndicator())
      ],
    );
  }


//================================================

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choisissez d'ou importer le justificatif",
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
    final fileName = path.basename(pickedFile!.path);
    print(fileName);
    print(pickedFile.name);
    setState(() {
      _imageFile = pickedFile;
      _importJustif.text = fileName;
    });
  }

//================================================
  Widget bonImage() {
    return Stack(
      children: <Widget>[
        TextFormField(
          controller: _importJustif,
          enabled: false,
          showCursor: true,
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 15.0),
            labelText: '        Importer justificatif',
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        // CircleAvatar(
        //   radius: 80.0,
        //   backgroundImage: _imageFile == null
        //       ? Vehicule.getImage("hehe") : FileImage(File(_imageFile!.path)) as ImageProvider ,
        // ),
        Positioned(
            top: 11,
            child: InkWell(
              onTap: () {
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

//================================================
  Widget Vehicules() =>
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
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                labelText: 'Kilometrage',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              onChanged: (String? value) {
                print(value);
              },
            ),
            SizedBox(height: 10,),
            Divider(thickness: 1,),
            SizedBox(height: 10,),
            TextFormField(
              controller: _montant,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "100 DH",
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                labelText: 'Montant',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              onChanged: (String? value) {
                print(value);
              },
            ),
          ],
        ),
      );


// -------------------------------------

  List? statesList;
  String? _myState;

  Future<List<Vehicule>> _getStateList() async {
    List<Vehicule> listMapped;
    final url = Uri.parse('http://$urlApi:3000/vehicules');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List vehicules = json.decode(response.body);
      listMapped = vehicules.map((json) => Vehicule.fromJson(json)).toList();
      setState(() {
        statesList = listMapped;
        vehiculeChoisie = listMapped[0];
        print(vehiculeChoisie);
      });
      return listMapped;
    } else {
      throw Exception();
    }
  }

  List? enginsList;

  Future<List<Engins>> _getEnginsList() async {
    List<Engins> listMapped;
    final url = Uri.parse('http://$urlApi:3000/engins');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List vehicules = json.decode(response.body);
      listMapped = vehicules.map((json) => Engins.fromJson(json)).toList();
      setState(() {
        enginsList = listMapped;
      });
      return listMapped;
    } else {
      throw Exception();
    }
  }
  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => GetBonGenere(file: file)),
  );
}
