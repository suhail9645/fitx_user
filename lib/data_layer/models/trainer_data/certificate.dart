import 'package:json_annotation/json_annotation.dart';

part 'certificate.g.dart';

@JsonSerializable()
class Certificate {
  int? id;
  dynamic title;
  dynamic description;
  String? file;

  Certificate({this.id, this.title, this.description, this.file});

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return _$CertificateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CertificateToJson(this);
}
