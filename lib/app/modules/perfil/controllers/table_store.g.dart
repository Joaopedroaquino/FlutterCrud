// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TableStore on _TableStore, Store {
  Computed<bool>? _$isValidNameComputed;

  @override
  bool get isValidName =>
      (_$isValidNameComputed ??= Computed<bool>(() => super.isValidName,
              name: '_TableStore.isValidName'))
          .value;
  Computed<bool>? _$isValidNameEditarComputed;

  @override
  bool get isValidNameEditar => (_$isValidNameEditarComputed ??= Computed<bool>(
          () => super.isValidNameEditar,
          name: '_TableStore.isValidNameEditar'))
      .value;

  late final _$perfilCreaterModelAtom =
      Atom(name: '_TableStore.perfilCreaterModel', context: context);

  @override
  PerfilCreaterModel get perfilCreaterModel {
    _$perfilCreaterModelAtom.reportRead();
    return super.perfilCreaterModel;
  }

  @override
  set perfilCreaterModel(PerfilCreaterModel value) {
    _$perfilCreaterModelAtom.reportWrite(value, super.perfilCreaterModel, () {
      super.perfilCreaterModel = value;
    });
  }

  late final _$newNameAtom =
      Atom(name: '_TableStore.newName', context: context);

  @override
  String get newName {
    _$newNameAtom.reportRead();
    return super.newName;
  }

  @override
  set newName(String value) {
    _$newNameAtom.reportWrite(value, super.newName, () {
      super.newName = value;
    });
  }

  late final _$perfilListModelAtom =
      Atom(name: '_TableStore.perfilListModel', context: context);

  @override
  PerfilListModel get perfilListModel {
    _$perfilListModelAtom.reportRead();
    return super.perfilListModel;
  }

  @override
  set perfilListModel(PerfilListModel value) {
    _$perfilListModelAtom.reportWrite(value, super.perfilListModel, () {
      super.perfilListModel = value;
    });
  }

  late final _$dataListAtom =
      Atom(name: '_TableStore.dataList', context: context);

  @override
  ObservableFuture<List<PerfilListModel>> get dataList {
    _$dataListAtom.reportRead();
    return super.dataList;
  }

  @override
  set dataList(ObservableFuture<List<PerfilListModel>> value) {
    _$dataListAtom.reportWrite(value, super.dataList, () {
      super.dataList = value;
    });
  }

  late final _$_TableStoreActionController =
      ActionController(name: '_TableStore', context: context);

  @override
  dynamic listarPerfis() {
    final _$actionInfo = _$_TableStoreActionController.startAction(
        name: '_TableStore.listarPerfis');
    try {
      return super.listarPerfis();
    } finally {
      _$_TableStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
perfilCreaterModel: ${perfilCreaterModel},
newName: ${newName},
perfilListModel: ${perfilListModel},
dataList: ${dataList},
isValidName: ${isValidName},
isValidNameEditar: ${isValidNameEditar}
    ''';
  }
}
