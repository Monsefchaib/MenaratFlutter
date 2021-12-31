
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suiviventes/AjoutCommande/AfficherCommandes/AfficherCommandes.dart';
import 'package:suiviventes/Models/Commande.dart';
import 'package:suiviventes/Models/vehicule.dart';
import 'package:path/path.dart' as path;

double? prixTT;
class ReserverCommande extends StatefulWidget {
  Commande? commande;
  ReserverCommande(Commande commande){
    this.commande=commande;
    prixTT=commande.prixTotal;
  }

  @override
  _ReserverCommandeState createState() => _ReserverCommandeState(this.commande);
}

class _ReserverCommandeState extends State<ReserverCommande> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _importJustif = TextEditingController();
  bool isLoading = false;
  final TextEditingController _positionController = TextEditingController()
    ..text = "Aucune location detectée";
  Commande? commande;
  _ReserverCommandeState(this.commande);
  TextEditingController avance = new TextEditingController();
  TextEditingController reste = new TextEditingController()..text=prixTT.toString();
  String _modePaiementValue = '';
  var modePaiement=['','Espèce','Chèque'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Reserver la commande"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                    Text("Réserver la commande : " + commande!.id! , style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,)),
                      SizedBox(height: 20,),
                     Row(
                        children: [
                          Image.asset(
                            'assets/images/user.png', height: 15,
                            width: 15,
                            fit: BoxFit.cover,),
                          SizedBox(width: 5), // give it width
                          Text(commande!.client!.nom + " " + commande!.client!.prenom,
                            style: TextStyle(fontSize: 13),),
                        ],
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: avance,
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          labelText: 'Avance',
                          border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            double avance = double.tryParse(value) ?? 0;
                             reste.text = (commande!.prixTotal! - avance).toString();
                          });
                        },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        enabled: false,
                        controller: reste,
                        decoration:  InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          labelText: 'Reste',
                          border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                      SizedBox(height: 20,),
                      InputDecorator(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          labelText: 'Mode de paiement',
                          border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                        ),
                        child:DropdownButton<String>(
                          isExpanded: true,
                          value: _modePaiementValue,
                          icon: const Icon(Icons.arrow_circle_down),
                          iconSize: 20,
                          elevation: 16,
                          underline: Container(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _modePaiementValue = newValue!;
                            });
                          },
                          items: List.generate(
                            modePaiement.length,
                                (index) => DropdownMenuItem(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    modePaiement[index]
                                ),
                              ),
                              value: modePaiement[index],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      if(_modePaiementValue == "Chèque") ...[
                        bonImage(),
                      ],
                      SizedBox(height: 20,),
                      getLocationWidget(),
                    ]

                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(right:8.0,left: 8.0),
          child: Row(
            children: <Widget>[
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // This is what you need!
                ),
                onPressed: () { Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (context) => new AfficherCommandes()));},
                child: Text("Réserver"),
              )
            ],
          ),
        ),
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
                Icons.location_on,
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

}
