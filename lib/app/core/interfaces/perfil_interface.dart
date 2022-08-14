import '../../modules/perfil/models/perfil_model.dart';

abstract class ClientInterface {
  Future<bool> createClient(
    String nome,
  );

  Future<bool> deleteClient(int id);

  Future<bool> updateClient(
    int id,
    String nome,
  );

  Future<List<PerfilModel>> getAllClients();

  Future<PerfilModel> getClientForId(int id);
}
