import 'dart:convert';

import 'package:mobx/mobx.dart';

class PerfilCreaterModel {
  int? id;
  String? nome;

  PerfilCreaterModel({
    this.id,
    this.nome,
  });

  factory PerfilCreaterModel.fromJson(Map<String, dynamic> json) {
    return PerfilCreaterModel(
      id: json['id'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
    };
  }
}
