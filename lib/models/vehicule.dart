class Vehicule {
  final int id;
  final String registrationNumber;
  final int constructorId;
  final String constructorName;
  final int modelId;
  final String modelName;
  final DateTime circulationDate;
  final String photoPath;
  final int engineTypeId;
  final String engineTypeName;
  final String temporaryModel;

  Vehicule(
      {required this.id,
      required this.registrationNumber,
      required this.constructorId,
      required this.constructorName,
      required this.modelId,
      required this.modelName,
      required this.circulationDate,
      required this.photoPath,
      required this.engineTypeId,
      required this.engineTypeName,
      required this.temporaryModel});

  factory Vehicule.fromJson(Map<String, dynamic> json) {
    return Vehicule(
      id: json["id"],
      registrationNumber: json["registrationNumber"],
      constructorId: json["constructorId"],
      constructorName: json["constructorName"],
      modelId: json["modelId"],
      modelName: json["modelName"],
      circulationDate: json["circulationDate"],
      photoPath: json["photoPath"],
      engineTypeId: json["engineTypeId"],
      engineTypeName: json["engineTypeName"],
      temporaryModel: json["temporaryModel"],
    );
  }
}
