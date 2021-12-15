class Engins{
  String nom;
  String montant;

  Engins(this.nom, this.montant);


  @override
  String toString() {
    return 'Engins{nom: $nom, montant: $montant}';
  }

  factory Engins.fromJson(dynamic json) {
    Engins engine = Engins(
      json['nom'] as String,
      json['montant'] as String,
    );
    return engine;
  }

  Map<String, dynamic> toJson() =>
      {

        'nom': this.nom,
        'montant': this.montant,

      };
}