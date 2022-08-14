// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';

import '../../modules/perfil/models/perfil_model.dart';
import '../config/api_service.dart';
import '../interfaces/perfil_interface.dart';

class ClienteRepository implements ClientInterface {
  Dio dio = Dio();

  @override
  Future<bool> createClient(
    String nome,
  ) async {
    bool success = false;

    PerfilModel clienteModel = PerfilModel(
      nome: nome,
    );

    print(jsonEncode(clienteModel.toJson()));

    var response =
        await dio.post(ApiService.CREATE_CLIENT, data: clienteModel.toJson());

    if (response.statusCode == 200) {
      print(response.data);
      if (response.data["message"] == "cliente Cadastrado com sucesso") {
        success = true;
      } else {
        success = false;
      }
    } else {
      success = false;
    }

    return success;
  }

  @override
  Future<bool> deleteClient(int id) async {
    bool success = false;

    PerfilModel perfilModel = PerfilModel(id: id);

    var response =
        await dio.post(ApiService.DELETE_CLIENT, data: perfilModel.toJson());

    if (response.statusCode == 200) {
      print(response.data);
      if (response.data["message"] == "cliente deletado com sucesso") {
        success = true;
      } else {
        success = false;
      }
    } else {
      success = false;
    }

    return success;
  }

  @override
  Future<List<PerfilModel>> getAllClients() async {
    List<PerfilModel> clientes = [];

    var response = await dio.post(ApiService.GET_ALL_CLIENTS);

    if (response.statusCode == 200) {
      var pp = response.data["result"] as List;

      print(jsonEncode(response.data));
      clientes = pp.map((json) => PerfilModel.fromJson(json)).toList();
    } else {
      clientes = [];
    }

    return clientes;
  }

  @override
  Future<PerfilModel> getClientForId(int id) async {
    PerfilModel clienteModel = PerfilModel(id: id);

    var response = await dio.post(ApiService.GET_CLIENT_FOR_ID,
        data: clienteModel.toJson());

    if (response.statusCode == 200) {
      print(jsonEncode(response.data));

      if (response.data["message"] == "cliente Encontrado") {
        clienteModel = PerfilModel.fromJson(response.data["result"][0]);
      } else {
        clienteModel.id = 0;
      }
    } else {
      clienteModel.id = 0;
    }

    return clienteModel;
  }

  @override
  Future<bool> updateClient(
    int id,
    String nome,
  ) async {
    bool success = false;

    var data = PerfilModel(id: id, nome: nome).toJson();

    print(data);

    var response = await dio.post(ApiService.UPDATE_CLIENT, data: data);

    if (response.statusCode == 200) {
      if (response.data["message"] == "cliente editado com sucesso") {
        success = true;
      } else {
        success = false;
      }
    } else {
      success = false;
    }

    return success;
  }
}
