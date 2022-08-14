import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../controllers/table_store.dart';
import '../../models/perfil_list_model.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  final source = ExampleSource();
  var sortIndex = 0;
  var sortAsc = true;
  final searchController = TextEditingController();

  final TableStore controllerTable = TableStore();

  @override
  void initState() {
    super.initState();
    searchController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          labelText: 'Buscar nome do perfil',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff47afc9)),
                          ),
                        ),
                        onSubmitted: (value) {
                          source.filterServerSide(searchController.text);
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        source.filterServerSide(searchController.text),
                    icon: const Icon(Icons.search),
                  ),
                  ElevatedButton(
                    child: Text("Cadastrar Perfil"),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 76, 175, 80),
                    ),
                    onPressed: () {
                      showDialog(
                        // barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Form(
                            child: AlertDialog(
                              scrollable: true,
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      onChanged:
                                          controllerTable.setNameCadastro,
                                      decoration: InputDecoration(
                                        labelText: 'Nome',
                                        hintText: 'Insira o nome do perfil',
                                        icon: const Icon(
                                          Icons.account_box,
                                          color: Color(0xff47afc9),
                                        ),
                                        // errorText:
                                        //     controllerTable.validateName(),
                                        labelStyle: const TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff47afc9)),
                                        errorStyle:
                                            const TextStyle(color: Colors.red),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff47afc9)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                Observer(
                                  builder: (_) => ElevatedButton(
                                    child: Text("Cadastrar"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                    ),
                                    onPressed: controllerTable.isValidName
                                        ? () async {
                                            controllerTable.cadastrar();

                                            Navigator.of(context).pop();
                                            await Future.delayed(
                                                const Duration(
                                                    milliseconds: 100), () {
                                              source.reloadPage();
                                            });
                                          }
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              AdvancedPaginatedDataTable(
                addEmptyRows: false,
                source: source,
                sortAscending: sortAsc,
                sortColumnIndex: sortIndex,
                loadingWidget: loadDadosTable,
                errorWidget: loadErrosTable,
                showFirstLastButtons: true,
                rowsPerPage: rowsPerPage,
                availableRowsPerPage: const [5, 10, 15],
                onRowsPerPageChanged: (newRowsPerPage) {
                  if (newRowsPerPage != null) {
                    setState(() {
                      rowsPerPage = newRowsPerPage;
                    });
                  }
                },
                columns: const [
                  DataColumn(label: Text('ID'), numeric: false),
                  DataColumn(label: Text('Nome do Perfil')),
                  DataColumn(label: Text('Ações')),
                ],
                //Optianl override to support custom data row text / translation
                getFooterRowText:
                    (startRow, pageSize, totalFilter, totalRowsWithoutFilter) {
                  final localizations = MaterialLocalizations.of(context);
                  var amountText = localizations.pageRowsInfoTitle(
                    startRow,
                    pageSize,
                    totalFilter ?? totalRowsWithoutFilter,
                    false,
                  );

                  if (totalFilter != null) {
                    //Filtered data source show addtional information
                    amountText += ' Filtrado de ($totalRowsWithoutFilter)';
                  }

                  return amountText;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setSort(int i, bool asc) => setState(() {
        sortIndex = i;
        sortAsc = asc;
      });

  Widget loadDadosTable() {
    return const Center(
      heightFactor: 10,
      child: CircularProgressIndicator(
          backgroundColor: Colors.grey, color: Color(0xff47afc9)),
    );
  }

  Widget loadErrosTable() {
    return const Center(heightFactor: 10, child: Text("Carregando dados..."));
  }
}

typedef SelectedCallBack = Function(String id, bool newSelectState);

class ExampleSource extends AdvancedDataTableSource<PerfilListModel> {
  List<String> selectedIds = [];
  String lastSearchTerm = '';

  // @override
  // DataRow? getRow(int index) =>
  //     lastDetails!.rows[index].getRow(selectedRow, selectedIds);

  @override
  DataRow getRow(int index) {
    final source = ExampleSource();
    lastDetails!.rows[index];
    return DataRow(
      cells: [
        DataCell(Text("${lastDetails!.rows[index].id}")),
        DataCell(Text("${lastDetails!.rows[index].nome}")),
        DataCell(
          Row(
            children: [
              Builder(
                builder: (context) {
                  return SizedBox.fromSize(
                    size: const Size(28, 28),
                    child: ClipOval(
                      child: Material(
                        color: const Color(0xff47afc9),
                        child: InkWell(
                          splashColor: Colors.white,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                var idSelect = lastDetails!.rows[index].id;

                                return Form(
                                  child: AlertDialog(
                                    scrollable: true,
                                    content: Column(
                                      children: [
                                        TextFormField(
                                          initialValue:
                                              lastDetails!.rows[index].nome,
                                          onChanged: (String value) async {
                                            controllerTable.setNameEditar(value,
                                                lastDetails!.rows[index].id!);
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Nome do perfil',
                                            // errorText: controllerTable
                                            //     .validateNameEditar(),
                                            icon: const Icon(
                                              Icons.account_box,
                                              color: Color(0xff47afc9),
                                            ),
                                            labelStyle: const TextStyle(
                                                fontSize: 15,
                                                color: Color(0xff47afc9)),
                                            errorStyle: const TextStyle(
                                                color: Colors.red),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff47afc9)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Observer(
                                              builder: (_) => ElevatedButton(
                                                child: Text("Editar Perfil"),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color(0xFFFF9800),
                                                ),
                                                onPressed: controllerTable
                                                        .isValidNameEditar
                                                    ? () async {
                                                        controllerTable
                                                            .editar();

                                                        await Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    100), () {
                                                          reloadPage();
                                                        });
                                                        Navigator.pop(context);
                                                      }
                                                    : null,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                                child: Text("Excluir Perfil"),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.red,
                                                ),
                                                onPressed: () {
                                                  print(idSelect);
                                                  controllerTable
                                                      .excluir(idSelect);
                                                  // await Future.delayed(
                                                  //     const Duration(
                                                  //         milliseconds: 100),
                                                  //     () {
                                                  //   reloadPage();
                                                  // });
                                                  Navigator.pop(context);
                                                }

                                                //  store.isValid ? store.validateAll : null,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Tooltip(
                                message: "Ver detalhes",
                                decoration: BoxDecoration(
                                  color: Color(0xff47afc9),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.white,
                                ),
                              ),
                              // <-- Icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
      // onSelectChanged: (newState) {
      //   callback(id.toString(), newState ?? false);
      // },
      // selected: selectedIds.contains(id.toString()),
    );
  }

  @override
  int get selectedRowCount => selectedIds.length;

  void selectedRow(String id, bool newSelectState) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    notifyListeners();
  }

  void filterServerSide(String filterQuery) async {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  void reloadPage() async {
    setNextView();
  }

  // var dataMock = {
  //   "totalRows": 10,
  //   "rows": [
  //     {"id": 1, "companyName": "Orn"},
  //     {"id": 2, "companyName": "Put"},
  //     {"id": 3, "companyName": "sss"},
  //     {"id": 4, "companyName": "kkk"},
  //     {"id": 5, "companyName": "kkk"},
  //     {"id": 6, "companyName": "kkk"},
  //     {"id": 7, "companyName": "kkk"},
  //     {"id": 8, "companyName": "kkk"},
  //     {"id": 9, "companyName": "kkk"},
  //     {"id": 10, "companyName": "kkk"}
  //   ]
  // };

  @override
  Future<RemoteDataSourceDetails<PerfilListModel>> getNextPage(
      NextPageRequest pageRequest) async {
    final Dio _dio = Dio();

    final response =
        await _dio.get('http://localhost:3333/perfil', queryParameters: {
      'offset': pageRequest.offset.toString(),
      'pageSize': pageRequest.pageSize.toString(),
      if (lastSearchTerm.isNotEmpty) 'nome': lastSearchTerm,
    });
    if (response.statusCode == 200) {
      // final data = dataMock;
      final data = response.data;

      return RemoteDataSourceDetails(
        data['totalRows'] as int,
        (data['rows'] as List<dynamic>)
            .map((json) => PerfilListModel.fromJson(json))
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? (data['rows'] as List<dynamic>).length
            : null,
      );
    } else {
      throw Exception('Erro de dados');
    }
  }
}
