import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dio/common/app_env.dart';
import 'package:flutter_dio/node.dart';
import 'node_list_state.dart';

class NodeListCubit extends Cubit<NodeListState> {
  NodeListCubit(this.dio)
      : super(NodeListState(nodeNameList: [], idNodeList: []));

  final Dio dio;

  Future<void> deleteFromNodeList(int index) async {
    List nodes = state.nodeNameList;
    List idNodeName = state.idNodeList;
    try {
      var result = await dio
          .delete('/node/' + idNodeName[index].toString());
      if (result.statusCode == 200) {
        nodes.removeAt(index);
        idNodeName.removeAt(index);
        emit(NodeListState(
            nodeNameList: nodes, idNodeList: idNodeName));
      }
    } on DioError catch (e) {}
  }

  Future<void> updateNodeList(int index, String newName) async {
    List nodes = state.nodeNameList;
    List idNodeName = state.idNodeList;
    nodes[index] = newName;
    emit(NodeListState(nodeNameList: nodes, idNodeList: idNodeName));
  }

  Future<void> getNodeList() async {
    //try {
      var result = await dio.get(AppEnv.node);

      List nodes = state.nodeNameList;
      List idNodeName = state.idNodeList;
      nodes.clear();
      idNodeName.clear();
      for (int i = 0; i < result.data.length; i++) {
        var data = Node.fromJson(result.data[i]);
        nodes.add(data.nodeTitle);
        idNodeName.add(data.id);
      }

      /*List<Node> test =
          (result.data as List).map((e) => Node.fromJson(e)).toList();

      List idNodeName = state.idNodeList;
      idNodeName.clear();
      for (int i = 0; i < result.data.length; i++) {
        var data = Node.fromJson(result.data[i]);
        idNodeName.add(data.id);
      }*/
      if (result.statusCode == 200) {
        emit(NodeListState(
            nodeNameList: nodes, idNodeList: idNodeName));
      }
    //} on DioError catch (e) {}
  }

  int getID(int index) {
    List idNodeName = state.idNodeList;
    return idNodeName[index];
  }
}
