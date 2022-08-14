import 'dart:convert';

import 'package:mobx/mobx.dart';

class PerfilModel {
  int? id;
  String? nome;

  PerfilModel({
    this.id,
    this.nome,
  });

  factory PerfilModel.fromJson(Map<String, dynamic> json) {
    return PerfilModel(
      id: json['id'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'nome': nome};
  }
}
