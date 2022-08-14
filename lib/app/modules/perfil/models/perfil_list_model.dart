import '../controllers/table_store.dart';

final TableStore controllerTable = TableStore();

class PerfilListModel {
  int? id;
  String? nome;

  PerfilListModel({
    this.id,
    this.nome,
  });

  factory PerfilListModel.fromJson(Map<String, dynamic> json) {
    return PerfilListModel(
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
