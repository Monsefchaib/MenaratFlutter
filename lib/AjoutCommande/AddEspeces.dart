

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _AddEspecesState extends State<AddEspeces> with InputValidationMixin{
  final formGlobalKey = GlobalKey < FormState > ();
  String _substratValue = '';
  String _conteneurValue = '';
  Lots lot = Lots(" "," ", " ", " ", " "," "," "," ",0," "," ", " ", " ",0);
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
        title: Text("Ajouter le produit"),
      ),
      body: Form(
        key: formGlobalKey,
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
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
                            subtitle: Text("Cliquez pour choisir un lot "),
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
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      validator: (montant) {
                        if (isNombreValide(int.tryParse(montant==null?"0":montant) ?? 0,lot)) return null;
                        else
                          return 'Maximum ${lot.quantite}';
                      },
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
                    SizedBox(height: 20,),
                    TextFormField(
                      validator: (montant) {
                        if (isMontantValid(double.tryParse(montant==null?"0":montant) ?? 0)) return null;
                        else
                          return 'Montant invalid';
                      },
                      controller: FprixUnitaire,
                        keyboardType: TextInputType.numberWithOptions(decimal: true,signed: false),
                        inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
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
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      Article article = Article(lot, double.parse(FprixUnitaire.text),int.parse(FnbrPlantes.text));
                      print(article.lot);
                      Navigator.pop(context, article);
                      },
                    child:Text("Ajouter le produit"),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
mixin InputValidationMixin {
  bool isDateValid(String date) => date.isNotEmpty && date!='';
  bool isSelectionValid(String selection) => selection.isNotEmpty && selection!='';
  bool isMontantValid(double montant)=> montant>0;
  bool isNombreValide(int nombre,Lots lot)=> nombre<=lot.quantite!;
  bool isJustifValid(String justif)=>justif.isNotEmpty && justif!='Aucun fichier choisi';
}