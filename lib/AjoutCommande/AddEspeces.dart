

import 'package:flutter/material.dart';
import 'package:suiviventes/Models/Article.dart';
import 'package:suiviventes/Models/Lots.dart';
import 'package:suiviventes/ProduitsForms/FiguierForm.dart';
import 'package:suiviventes/ProduitsForms/OlivierForm.dart';
import 'package:suiviventes/ProduitsForms/PommierForm.dart';

import '../ProduitsForms/AmandierForm.dart';
import '../ProduitsForms/ArganierForm.dart';
import '../ProduitsForms/CaroubierForm.dart';
import '../ProduitsForms/VigneForm.dart';
import 'SearchLots.dart';

class AddEspeces extends StatefulWidget {
  @override
  _AddEspecesState createState() => _AddEspecesState();
}

class _AddEspecesState extends State<AddEspeces> {
  var _locations = ['Olivier', 'Amandier', 'Arganier', 'Figuier',"Pommier","Caroubier","Vigne"];
  String _substratValue = '';
  String _conteneurValue = '';
  Lots lot = Lots(" ", " ", " ", " ", 0, 0);
  bool isLots = false;
  List listLots = [];
  var susbtrat=['','SOL','TOURBE'];
  var conteneur=['','POT','SACHET'];
  String selectedLocation = 'Olivier';
  final FnbrPlantes = TextEditingController();
  final FprixUnitaire = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter les especes"),
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
              children: [
                SizedBox(height: 10,),
                Divider(thickness: 1,),
                Column(
                  children: [
                    ListTile(
                      title: Text("Lot :", style: TextStyle(fontWeight: FontWeight.bold)),
                      onTap: () async {
                        lot = await Navigator.of(context).push(
                            new MaterialPageRoute(
                                builder: (context) => new SearchLots()));
                        setState(() {
                          lot=lot;
                          isLots=true;
                        });
                      },
                      subtitle: Text("Cliquer pour choisir un lot et les produits"),
                      trailing: Icon(Icons.arrow_forward_ios),

                    ),
                    if(isLots==true)...[
                                ListTile(
                                leading: Icon(Icons.check),
                                trailing: Text("${lot.variete}",
                                  style: TextStyle(
                                      color: Colors.green,fontSize: 15),),
                                title:Text(lot.espece!)
                            ),
                    ]
                  ],
                ),
                Divider(thickness: 1,),
                SizedBox(height: 10,),
                InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    labelText: 'Substrat',
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  child:DropdownButton<String>(
                    isExpanded: true,
                    value: _substratValue,
                    icon: const Icon(Icons.arrow_circle_down),
                    iconSize: 20,
                    elevation: 16,
                    underline: Container(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _substratValue = newValue!;
                        print(_substratValue);
                      });
                    },
                    items: List.generate(
                      susbtrat.length,
                          (index) => DropdownMenuItem(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              susbtrat[index]
                          ),
                        ),
                        value: susbtrat[index],
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
                    labelText: 'Conteneur',
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  child:DropdownButton<String>(
                    isExpanded: true,
                    value: _conteneurValue,
                    icon: const Icon(Icons.arrow_circle_down),
                    iconSize: 20,
                    elevation: 16,
                    underline: Container(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _conteneurValue = newValue!;
                        print(_conteneurValue);
                      });
                    },
                    items: List.generate(
                      conteneur.length,
                          (index) => DropdownMenuItem(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              conteneur[index]
                          ),
                        ),
                        value: conteneur[index],
                      ),
                    ),
                  ),
                ),
                Divider(thickness: 1,),
                SizedBox(height: 10,),
                TextFormField(
                  controller: FnbrPlantes,
                  keyboardType: TextInputType.number,
                  decoration:  InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    labelText: 'Nombre de plantes',
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onChanged: (String? value){
                    print(value);
                  },
                ),
                Divider(thickness: 1,),
                SizedBox(height: 10,),
                TextFormField(
                  controller: FprixUnitaire,
                  keyboardType: TextInputType.number,
                  decoration:  InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    labelText: 'Prix Unitaire',
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onChanged: (String? value){
                    print(value);
                  },
                ),
                SizedBox(height: 10,),
                Divider(),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: (){
                  Article article = Article(lot, _substratValue, _conteneurValue, double.parse(FprixUnitaire.text),double.parse(FnbrPlantes.text));
                  Navigator.pop(context, article);
                  },
                child:Text("Ajouter le lot"),
                ),
              ],
      ),
    );
  }
}
