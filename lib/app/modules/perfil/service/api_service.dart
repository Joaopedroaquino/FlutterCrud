import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/perfil_create_model.dart';
import '../models/perfil_list_model.dart';
import '../models/perfil_model.dart';

class ApiService {
  late List<PerfilModel> listPerfil;

  final Dio _dio = Dio();

  Future<PerfilModel?> cadastraPerfil(PerfilCreaterModel perfil) async {
    final apiResponse =
        await _dio.post('http://localhost:3333/perfil', data: perfil);

    if (apiResponse.statusCode == 201) {
      Fluttertoast.showToast(
        msg: "Cadastrado com sucesso",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        webBgColor: "linear-gradient(to right, #4CAF50, #4CAF50)",
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return apiResponse.data;
    } else {
      Fluttertoast.showToast(
        msg: "Erro ao cadastrar",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        webBgColor: "linear-gradient(to right, #F44336, #F44336)",
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return null;

    // return null;

    // debugPrint("resposta: ${apiResponse.statusCode}");
    // debugPrint("resposta: ${apiResponse.data}");
    // return PerfilModel.fromJson(apiResponse.data);
  }

  Future<PerfilModel?> editaPerfil(PerfilCreaterModel perfil) async {
    final apiResponse =
        await _dio.put('http://localhost:3333/perfil', data: perfil);

    if (apiResponse.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Editado com sucesso",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        webBgColor: "linear-gradient(to right, #4CAF50, #4CAF50)",
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return apiResponse.data;
    } else {
      Fluttertoast.showToast(
        msg: "Erro ao editar",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        webBgColor: "linear-gradient(to right, #F44336, #F44336)",
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return null;

    // return null;

    // debugPrint("resposta: ${apiResponse.statusCode}");
    // debugPrint("resposta: ${apiResponse.data}");
    // return PerfilModel.fromJson(apiResponse.data);
  }

  Future<PerfilModel?> excluirPerfil(int id) async {
    final apiResponse = await _dio.delete('http://localhost:3333/perfil/$id');

    if (apiResponse.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Excluído com sucesso",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        webBgColor: "linear-gradient(to right, #4CAF50, #4CAF50)",
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return apiResponse.data;
    } else {
      Fluttertoast.showToast(
        msg: "Erro ao excluir",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        webBgColor: "linear-gradient(to right, #F44336, #F44336)",
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return null;

    // return null;

    // debugPrint("resposta: ${apiResponse.statusCode}");
    // debugPrint("resposta: ${apiResponse.data}");
    // return PerfilModel.fromJson(apiResponse.data);
  }

  Future<List<PerfilListModel>> listarPerfil() async {
    final apiResponse = await _dio.get('http://localhost:3333/perfil');
    return (apiResponse.data as List)
        .map((item) => PerfilListModel.fromJson(item))
        .toList();
  }

  String lastSearchTerm = '';
}
