class Transport{
  String nomChauffeur;
  String numTelephone;
  String immVehicule;

  Transport(this.nomChauffeur, this.numTelephone, this.immVehicule);

  @override
  String toString() {
    return 'Transport{nomChauffeur: $nomChauffeur, numTelephone: $numTelephone, immVehicule: $immVehicule}';
  }

}