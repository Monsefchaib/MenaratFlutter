
import 'package:flutter/material.dart';
import 'package:suiviventes/AjoutCommande/ReserverCommande/ModifierArticleDeCommande.dart';
import 'package:suiviventes/Models/Article.dart';
import 'package:suiviventes/Models/Commande.dart';
import 'package:suiviventes/Models/Lots.dart';

import '../AddEspeces.dart';

class ModifierCommande extends StatefulWidget {
  Commande? commande;
  ModifierCommande(this.commande);

  @override
  _ModifierCommandeState createState() => _ModifierCommandeState(this.commande);
}

class _ModifierCommandeState extends State<ModifierCommande> {
  Article article = Article(Lots(" "," ", " ", " ", " ", 0, 0),"","",0,0);
  Commande? commande;

  _ModifierCommandeState(this.commande);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Modifier la commande "),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
                        InkWell(
                        onTap: () async { article = await Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new AddEspeces()));
                  setState(() {
                  article = article;
                  commande!.articles!.add(article);
                  });
                  },
                    child: ListTile(
                      title: Text('Lots',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                      subtitle: Text("Ajouter les produits à vendre"),
                      trailing: Wrap(
                        spacing: 12, // space between two icons
                        children: <Widget>[
                          Icon(Icons.add),
                          // icon-2
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                  shrinkWrap: true,
                  itemCount: commande!.articles!.length,
                  itemBuilder: (BuildContext context,int index){
                  return Row(
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          commande!.articles!.removeAt(index);
                        });
                      },
                          iconSize:15,
                          color: Colors.red,
                          icon: Icon(Icons.remove_circle)
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width-60,
                        child: InkWell(
                          onTap: ()
                            async { commande!.articles![index] = await Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new ModifierArticle(commande!.articles![index])));
                            setState(() {
                                commande!.articles![index] = commande!.articles![index];
                            });
                            },
                          child: ListTile(
                          leading: Icon(Icons.edit,color: Colors.green),
                          trailing: Text("Quantité : ${commande!.articles![index].quantite}",
                          style: TextStyle(
                          color: Colors.green,fontSize: 15),),
                          title:Text("${commande!.articles![index].lot!.variete}"),
                          ),
                        ),
                      ),
                    ],
                  );
                  }
                  ),
            SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent, // This is what you need!
              ),
              onPressed: () async {
                showAlertDialog(context);
                await Commande.updateCommande(commande!);
                Navigator.pop(context);
                Navigator.pop(context);},
              child: Text("Modifier la commande"),
            )
    ],
        ),
      ),
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
