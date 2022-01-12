import 'package:flutter/material.dart';
import 'package:suiviventes/Models/Commande.dart';
import 'package:suiviventes/Models/Livraison.dart';
import 'package:suiviventes/Models/Ordre.dart';
import 'package:suiviventes/Models/OrdreItems.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'OrdreDeLivraison.dart';

int resteGlobal=0;
late String haha="haha";
class AjouterLivraison extends StatefulWidget {
  List<int>? reste;
  int index;
  Commande? commande;
  Ordre? ordre;
  AjouterLivraison(this.ordre,this.commande,this.index,this.reste);
  @override
  _AjouterLivraisonState createState() => _AjouterLivraisonState(this.ordre!,this.commande,this.index,this.reste);
}

class _AjouterLivraisonState extends State<AjouterLivraison> with InputValidationMixin {
  final formGlobalKey = GlobalKey < FormState > ();
  List<int>? reste;
  int index;
  Ordre? ordre;
  Commande? commande;
  _AjouterLivraisonState(this.ordre,this.commande,this.index,this.reste);
  final List<TextEditingController> _articlesController = List.generate(
      50, (i) => TextEditingController(),growable: true);
  DateTime _date = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter une livraison"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: ListView(
            children: <Widget> [
              SizedBox(height: 20,),
              Text("Saisir le nombre d'espèces à livrer :",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
              SizedBox(height: 20,),
              Form(
                autovalidate: true,
                  key: formGlobalKey,
                child: ListView.builder(
                  itemCount: ordre!.itemsToOrder!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _articlesController[index],
                              keyboardType: TextInputType.number,
                              validator: LYDPhoneValidator(reste![index]),
                          decoration:  InputDecoration(
                                hintText: 'Maximum ${reste![index]}',
                                // errorText: validatePassword(_articlesController[index].text),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                labelText: ordre!.itemsToOrder![index].variete,
                                border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                              ),
                              onChanged: (String? value){
                                setState(() {});
                              },
                            ),
                          ]
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed:
                () async{
                if(formGlobalKey.currentState!.validate()){
                  List<OrderItem>? listToOrder = [];
                  for(int i=0;i<ordre!.itemsToOrder!.length;i++){
                    if(_articlesController[i]!=null){
                      OrderItem articleToOrder = new OrderItem(ordre!.itemsToOrder![i].espece,ordre!.itemsToOrder![i].variete,int.tryParse(_articlesController[i].text)?? 0);
                      listToOrder.add(articleToOrder);
                    }
                  }
                  Livraison livraison = new Livraison("${_date.day}-${_date.month}-${_date.year}",listToOrder);
                  if(commande!.listOrdres![index].livraisons==null){
                    commande!.listOrdres![index].livraisons=[];
                    commande!.listOrdres![index].livraisons!.add(livraison);
                  }else{
                    commande!.listOrdres![index].livraisons!.add(livraison);
                  }
                  showAlertDialog(context);
                  await Commande.updateCommande(commande!);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new OrdreDeLivraison(commande!)));
                }else{
                  print("not validated");
                }

              }

              , child: Text("Livrer")),

            ]
        ),
      )
    );
  }
  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 8),child:Text("Chargement ..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;

}

class LYDPhoneValidator extends TextFieldValidator {
   int reste;

  LYDPhoneValidator(this.reste, {String errorText = 'Maximum ' }) : super(errorText+"${reste}");

  @override
  bool isValid(String? value) {
    return int.parse(value!)<reste+1 && value.isNotEmpty ?  true:false ;
  }

}  