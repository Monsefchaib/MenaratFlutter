class Produit {
  late String espece;
  late String variete;
  late String substrat;
  late String conteneur;
  late int nbrPlantes;
  late double prixUnitaire;
  late String porteGreffe;

  Produit(this.espece, this.variete, this.substrat, this.conteneur,
      this.nbrPlantes, this.prixUnitaire, this.porteGreffe);

  Produit.vide();

  @override
  String toString() {
    return 'Produits{espece: $espece, variete: $variete, substrat: $substrat, conteneur: $conteneur, nbrPlantes: $nbrPlantes, prixUnitaire: $prixUnitaire , porteGreffe:$porteGreffe}';
  }
}