
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:suiviventes/AjoutCommande/Livraisons/OrdreDeLivraison.dart';
import 'package:suiviventes/Models/Commande.dart';
import 'package:suiviventes/Models/Ordre.dart';
import 'package:suiviventes/Models/OrdreItems.dart';

class AddOrdreDeLivraison extends StatefulWidget {
  Commande? commande;
  AddOrdreDeLivraison(this.commande);

  @override
  _AddOrdreDeLivraisonState createState() => _AddOrdreDeLivraisonState(this.commande);
}

class _AddOrdreDeLivraisonState extends State<AddOrdreDeLivraison> {
  List<int> reste =  List.generate(
      50, (i) => 0,growable: true);
  List<int>? totalOrdres = List.generate(
      50, (i) => 0,growable: true);
  List<int>? totalQuantite = List.generate(
      50, (i) => 0,growable: true);
  final formGlobalKey = GlobalKey < FormState > ();
  final List<TextEditingController> _articlesController = List.generate(
      50, (i) => TextEditingController(),growable: true);
  Commande? commande;
  _AddOrdreDeLivraisonState(this.commande);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un ordre de livraison"),
      ),
      body:  Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: ListView(
          children: <Widget> [
            SizedBox(height: 20,),
            Text("Saisir le nombre d'espèces pour ordre de livraison :",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
            SizedBox(height: 20,),
            Form(
              autovalidate: true,
              key: formGlobalKey,
              child: ListView.builder(
                itemCount: commande!.articles!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            validator: LYDPhoneValidator(reste[index]),
                            controller: _articlesController[index],
                            keyboardType: TextInputType.number,
                            decoration:  InputDecoration(
                              hintText: 'Maximum ${reste[index]}',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15.0),
                              labelText: commande!.articles![index].lot!.variete!,
                              border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                            ),
                            onChanged: (String? value){
                            },
                          ),
                        ]
                    ),
                  );
                },
        ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async{
              List<OrderItem>? listToOrder = [];
              for(int i=0;i<commande!.articles!.length;i++){
                if(_articlesController[i]!=null){
                  OrderItem articleToOrder = new OrderItem(commande!.articles![i].lot!.espece,commande!.articles![i].lot!.variete,int.tryParse(_articlesController[i].text)?? 0);
                  listToOrder.add(articleToOrder);
                }
              }
                Ordre order = new Ordre.vide();
                order.itemsToOrder=listToOrder;
                commande!.listOrdres!.add(order);
                showAlertDialog(context);
                 await Commande.updateCommande(commande!);
                Navigator.pop(context);
              Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new OrdreDeLivraison(commande!)));

            }, child: Text("Ajouter")),

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

  calculReste(){

    for (int i = 0; i < commande!.articles!.length; i++) {
      totalQuantite![i]=commande!.articles![i].quantite!.toInt();
    }
    for (int i = 0; i < commande!.listOrdres!.length; i++) {
      for (int j = 0; j < commande!.listOrdres![i].itemsToOrder!.length; j++) {
        totalOrdres![j] +=
        commande!.listOrdres![i].itemsToOrder![j].nombreALivrer!;
      }
    }
    for (int i = 0; i < commande!.articles!.length; i++) {
      reste[i]=totalQuantite![i]-totalOrdres![i];
    }
  }

  @override
  void initState() {
    calculReste();
  }
}

class LYDPhoneValidator extends TextFieldValidator {
  int reste;

  LYDPhoneValidator(this.reste, {String errorText = 'Maximum ' }) : super(errorText+"${reste}");

  @override
  bool isValid(String? value) {
    return int.parse(value!)<reste+1 && value.isNotEmpty ?  true:false ;
  }

}