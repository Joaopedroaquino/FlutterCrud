import 'package:dio/dio.dart';

import 'package:mobx/mobx.dart';

import '../models/perfil_create_model.dart';
import '../models/perfil_list_model.dart';
import '../models/perfil_model.dart';
import '../service/api_service.dart';
part 'table_store.g.dart';

class TableStore = _TableStore with _$TableStore;

abstract class _TableStore with Store {
  final ApiService apiService = ApiService();

  @observable
  var perfilCreaterModel = PerfilCreaterModel();

  @observable
  String newName = '';

  setNameCadastro(String value) {
    newName = value;
    perfilCreaterModel.nome = newName;
  }

  String? validateName() {
    if (newName.isEmpty) {
      return "";
    }

    return null;
  }

  @computed
  bool get isValidName {
    return validateName() == null;
  }

  @observable
  var perfilListModel = PerfilListModel();

  setNameEditar(String value, int id) {
    newName = value;
    perfilCreaterModel.nome = newName;
    perfilCreaterModel.id = id;
  }

  String? validateNameEditar() {
    if (newName.isEmpty) {
      return "";
    }

    return null;
  }

  @computed
  bool get isValidNameEditar {
    return validateNameEditar() == null;
  }

  void cadastrar() async {
    _postCreate(perfilCreaterModel);
  }

  Future<PerfilModel> _postCreate(PerfilCreaterModel perfil) async {
    try {
      var res = await apiService.cadastraPerfil(perfil);
      //return res;
    } on DioError catch (err) {
      print('Err ${err.response?.statusCode}');
    }
    return null;
  }

  void editar() async {
    _postEdit(perfilCreaterModel);
  }

  Future<PerfilModel> _postEdit(PerfilCreaterModel perfil) async {
    try {
      var res = await apiService.editaPerfil(perfil);
      //return res;
    } on DioError catch (err) {
      print('Err ${err.response?.statusCode}');
    }
    return null;
  }

  void excluir(id) async {
    _postDelete();
  }

  Future<PerfilModel> _postDelete() async {
    try {
      var res = await apiService.excluirPerfil(perfilCreaterModel.id!);
      return res;
    } on DioError catch (err) {
      print('Err ${err.response?.statusCode}');
    }
    return null;
  }

  @observable
  late ObservableFuture<List<PerfilListModel>> dataList;

  @action
  listarPerfis() {
    dataList = apiService.listarPerfil().asObservable();
  }
}
