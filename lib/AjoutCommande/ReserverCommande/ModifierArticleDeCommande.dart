
import 'package:flutter/material.dart';
import 'package:suiviventes/Models/Article.dart';

class ModifierArticle extends StatefulWidget {
  Article? article;
  ModifierArticle(this.article);

  @override
  _ModifierArticleState createState() => _ModifierArticleState(this.article);
}

class _ModifierArticleState extends State<ModifierArticle> {
  Article? article;
  _ModifierArticleState(Article? article){
    this.article=article;
    this.FprixUnitaire.text=this.article!.prixUnitaire.toString();
    this.FnbrPlantes.text=this.article!.quantite.toString();
  }
  final FnbrPlantes = TextEditingController();
  final FprixUnitaire = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier Article"),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
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
              article!.prixUnitaire=double.parse(FprixUnitaire.text);
              article!.quantite=int.parse(FnbrPlantes.text);
              Navigator.pop(context, article);
            },
              child:Text("Modifier l'article"),
            ),
          ],
        ),
      ),
    );
  }
}
