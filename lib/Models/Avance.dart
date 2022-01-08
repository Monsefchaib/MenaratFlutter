class Avance{
  double? montant;
  String? modePaiement;
  String? justifUrl;
  String? location;

  Avance(this.montant, this.modePaiement, this.justifUrl, this.location);

  @override
  String toString() {
    return 'Avance{montant: $montant, modePaiement: $modePaiement, justifUrl: $justifUrl, location: $location}';
  }

  Map<String, dynamic> toJson() {
    return {
      'montant': this.montant,
      'modePaiement': this.modePaiement,
      'justifUrl': this.justifUrl,
      'location': this.location,
    };
  }
  factory Avance.fromJson(dynamic json) {
    Avance avance = Avance(
      (json['montant'] as num).toDouble(),
      json['modePaiement'] as String,
      json['justifUrl'] as String,
      json['location'] as String,
    );
    return avance;
  }
}