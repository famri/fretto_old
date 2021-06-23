class JourneyRequestProposalDto {
  final int id;
  final double price;
  final StatusDto status;
  final TransporterDto transporter;
  final VehiculeDto vehicule;

  JourneyRequestProposalDto(
      {required this.id,
      required this.price,
      required this.status,
      required this.transporter,
      required this.vehicule});

  factory JourneyRequestProposalDto.fromJson(Map<String, dynamic> json) {
    return JourneyRequestProposalDto(
        id: json["id"],
        price: json["price"],
        status: StatusDto.fromJson(json["status"]),
        transporter: TransporterDto.fromJson(json["transporter"]),
        vehicule: VehiculeDto.fromJson(json["vehicule"]));
  }
}

class StatusDto {
  final String code;
  final String value;
  StatusDto({required this.code, required this.value});

  factory StatusDto.fromJson(Map<String, dynamic> json) {
    return StatusDto(code: json['code'], value: json['value']);
  }
}

class VehiculeDto {
  final int id;
  final String constructor;
  final String model;
  final String photoUrl;

  VehiculeDto(
      {required this.id,
      required this.constructor,
      required this.model,
      required this.photoUrl});

  factory VehiculeDto.fromJson(Map<String, dynamic> json) {
    return VehiculeDto(
        id: json['id'],
        constructor: json['constructor'],
        model: json['model'],
        photoUrl: json['photoUrl']);
  }
}

class TransporterDto {
  final int id;
  final String firstname;
  final String photoUrl;
  final double globalRating;

  TransporterDto(
      {required this.id,
      required this.firstname,
      required this.photoUrl,
      required this.globalRating});

  factory TransporterDto.fromJson(Map<String, dynamic> json) {
    return TransporterDto(
      id: json['id'],
      firstname: json['firstname'],
      photoUrl: json['photoUrl'],
      globalRating: json['globalRating'],
    );
  }
}
