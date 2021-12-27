import 'package:flutter/material.dart';
import 'package:suiviventes/Models/Lots.dart';
import 'package:suiviventes/Models/Produits.dart';

enum SortType { asc, desc }
enum EspeceType {i,Olivier, Amandier,Arganier,Caroubier,Figuier,Pommier,Vigne }
enum VarieteOlivier {ARBEQUINA, ARBOSANA, PICHOLINE ,LINGUE, DALIA,TASSAOUTE}

class SearchLots extends StatefulWidget {
  @override
  _SearchLotsState createState() => _SearchLotsState();
}

class _SearchLotsState extends State<SearchLots> {
  List<Produit> listProduits = [];
  var index = 0;
  VarieteOlivier? _varieteOlivier = VarieteOlivier.ARBEQUINA;
  EspeceType? _variete = EspeceType.i;
  SortType? _sort = SortType.desc;
  String _varieteChoisie="";
  String _sortType="";
  var selectedEspece = "";
  var selectedVariete = "";
  var varToSearch = "";
  bool searchVariete = false;
  List<int> _itemCount = List.filled(50, 0, growable:true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chercher les lots"),
        actions: <Widget>[
          IconButton(onPressed: () {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                isScrollControlled: true,

                context: context,
                builder: (_) => StatefulBuilder(
                builder: (BuildContext context, StateSetter mystate /*You can rename this!*/) {
                  return makeDismissible(
                        child: DraggableScrollableSheet(

                          maxChildSize: 0.9,
                          minChildSize: 0.3,
                          initialChildSize: 0.7,
                          builder: (_, controller) =>
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30),
                                    )
                                ),
                                padding: EdgeInsets.all(16),
                                child: ListView(
                                  controller: controller,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Filtres ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                                        IconButton(onPressed:()=> {
                                          setState(() {
                                          }),
                                          Navigator.of(context).pop(),
                                        }, icon: Icon(Icons.close,color: Colors.black)),
                                      ],
                                    ),

                                    SizedBox(height: 20),
                                    Text("Trier par", style: TextStyle(fontWeight: FontWeight.bold)),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                            Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: RadioListTile<SortType>(
                                              contentPadding: EdgeInsets.all(0.0), dense: true,
                                              title: const Text('Quantité : croissante'),
                                              value: SortType.asc,
                                              groupValue: _sort,
                                              onChanged: (SortType? value) {
                                                mystate(() {
                                                  _sort = value;
                                                  _sortType=_sort.toString().split('.').last;
                                                  print(_sort.toString().split('.').last);
                                                });
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: RadioListTile<SortType>(
                                              contentPadding: EdgeInsets.all(0.0), dense: true,
                                              title: const Text('Quantité : décroissante '),
                                              value: SortType.desc,
                                              groupValue: _sort,
                                              onChanged: (SortType? value) {
                                                mystate(() {
                                                  _sort = value;
                                                  _sortType=_sort.toString().split('.').last;
                                                  print(_sort.toString().split('.').last);
                                                });
                                              },
                                            ),
                                          ),
                                          ]
                                            ),
                                        ],
                                      ),
                                    ),
                                    Divider(thickness: 1),
                                    SizedBox(height: 20),
                                    Text("Espèce", style: TextStyle(fontWeight: FontWeight.bold)),
                                    FutureBuilder(
                                        future: Produit.getProduits(),
                                        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(child: CircularProgressIndicator());
                                          }
                                          listProduits=snapshot.data as List<Produit>;
                                          return GridView.builder(
                                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 200.0,
                                                mainAxisSpacing: 0.0,
                                                crossAxisSpacing: 0.0,
                                                childAspectRatio: 4.0,
                                              ),
                                              shrinkWrap: true,
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (context, i) {
                                                return
                                                  RadioListTile<dynamic>(
                                                  title: Text(snapshot.data![i].espece),
                                                value: snapshot.data![i].espece,
                                                groupValue: selectedEspece,
                                                onChanged: (value) {
                                                mystate(() {
                                                  index=i;
                                                selectedEspece = value;
                                                  searchVariete=false;

                                                });
                                                },
                                                );
                                              }
                                          );
                                        }
                                    ),
                                    Divider(thickness: 1),
                                    SizedBox(height: 20),
                                    Text("Varieté", style: TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 20),
                                     FutureBuilder(
                                          future: Produit.getProduits(),
                                          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(child: CircularProgressIndicator());
                                            }
                                            listProduits=snapshot.data as List<Produit>;
                                            return GridView.builder(
                                                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent: 200.0,
                                                  mainAxisSpacing: 0.0,
                                                  crossAxisSpacing: 0.0,
                                                  childAspectRatio: 4.0,
                                                ),
                                                shrinkWrap: true,
                                                itemCount: listProduits[index].varietee!.length,
                                                itemBuilder: (context, i) {
                                                  if(listProduits[index].varietee != null) {
                                                    return
                                                      RadioListTile<dynamic>(
                                                        title: Text(
                                                            listProduits[index]
                                                                .varietee![i]),
                                                        value: listProduits[index]
                                                            .varietee![i],
                                                        groupValue: selectedVariete,
                                                        onChanged: (value) {
                                                          mystate(() {
                                                            selectedVariete =
                                                                value;
                                                            searchVariete=true;
                                                          });
                                                        },
                                                      );
                                                  }
                                                  else return Container();
                                                }
                                            );
                                          }
                                      ),
                     ],
                                ),
                              ),
                        ),
                      );
                }));
          }, icon: Icon(Icons.toc)),
        ],
      ),
      body: FutureBuilder(
          future: Lots.getLots(searchVariete ? selectedVariete : selectedEspece,_sort.toString().split('.').last),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: <Widget>[
                      InkWell(
                      onTap: (){Navigator.pop(context, snapshot.data![i]);},
                        child: Container(
                          height: 120.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          child: new Stack(
                            children: <Widget>[
                              lotCard(snapshot.data![i],i),
                              lotThumbnail(snapshot.data!),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
            );
          }
      ),
    );
  }

  Widget makeDismissible({required Widget child})=> GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap:()=> {
    setState(() {
    }),
      Navigator.of(context).pop(),
    },
    child: GestureDetector(onTap: (){},child:child),
  );


   lotCard(dynamic snapshot, int i){ return Container(
          height: 170.0,
         margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: new Color.fromRGBO(255, 255, 255, 1),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
         ),
        ],
      ),
    child: Padding(
      padding: const EdgeInsets.only(left:60.0,top: 8),
      child: Column(
        children: <Widget>[
              Row(
              children: [
              Text("Code lot :  ", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.lightGreen)),
              Text("Code lot"),

              ],
          ),
          Row(
          children: [
          Text("Site :  ", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.lightGreen)),
          Text(snapshot.site),
          ],
          ),
          Row(
          children: [
          Text("Zone :  ", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.lightGreen)),
          Text(snapshot.zone),
          ],
          ),
          Row(
          children: [
          Text("Espèce :  ", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.lightGreen)),
          Text(snapshot.espece),
          ]),
          Row(
              children: [
                Text("Varieté :  ", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.lightGreen)),
                Text(snapshot.variete),
              ]),
          Row(
              children: [
                Text("Quantité :  ", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.lightGreen)),
                Text('${snapshot.quantite}'),
              ]),
          // Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Text("Quantité Reservée:  ", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color:Colors.redAccent)),
          //       _itemCount[i]!=0? new IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount[i]--),):new Container(),
          //       new Text(_itemCount[i].toString()),
          //       new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount[i]++)),
          //     ]),
        ],
      ),
    ),
    );
  }

  lotThumbnail(List<dynamic> snapshot) {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: 25.0
        ),
        // alignment: FractionalOffset.centerLeft,
        child: Container(
          height: 100,
          width: 100,
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage:
            NetworkImage("https://cutt.ly/uY3TGtz"),
            backgroundColor: Colors.transparent,
          ),
        )
    );
  }


}
