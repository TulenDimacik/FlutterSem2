import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dio/common/app_env.dart';
import 'package:flutter_dio/node.dart';
import 'node_parametrs_state.dart';

class NodeParametrsCubit extends Cubit<NodeParametrsState> {
  NodeParametrsCubit(this.dio) : super(NodeParametrsState(id: 0, nodeTitle: '', nodeDescription: '',createDate: '',updateDate: '',isDeleted: false,categoryNameList: [],idCategoryList: [], idCategory: 0));
 
  final Dio dio;

  Future<void> addNode(Node nodedata)async{
    try{
      var response = await dio.post('/node',data: nodedata);
      if(response.statusCode == 200){
      }
    } on DioError catch(e){
      print(e.response!.data['message']);
    }
  }

  Future<void> updateNodeParametrs(Node nodedata)async{
    try{
      var response = await dio.put('/node/'+nodedata.id.toString(),data: nodedata);
      if(response.statusCode == 200){
      }
    } on DioError catch(e){
      print(e.response!.data['message']);
    }
  }

  Future<void> logicalDelete(int id)async{
    try{
      var response = await dio.put('/node/delete/'+id.toString());
      if(response.statusCode == 200){
      }
    } on DioError catch(e){
      print(e.response!.data['message']);
    }
  }

  Future<void> logicalReturn()async{
    try{
      var response = await dio.put('/node/delete');
      if(response.statusCode == 200){
        print('Логично восстановил');
      }
    } on DioError catch(e){
      print(e.response!.data['message']);
    }
  }

  String getCategoryFromID(int categoryID) {
    List idCategoryList = state.idCategoryList;
    List<String> categoryList = state.categoryNameList;
    categoryID = idCategoryList.indexOf(categoryID);
    return categoryList[categoryID];
  }

  int getIDCategoryFromName(String nameCategory) {
    List idCategoryList = state.idCategoryList;
    List<String> categoryList = state.categoryNameList;
    int index = categoryList.indexOf(nameCategory);
    return idCategoryList[index];
  }

  Future<void> getCategories() async{
    var response = await dio.get(AppEnv.category);
          if(response.statusCode == 200){
            List<String> categoryList = state.categoryNameList;
            List idCategoryList = state.idCategoryList;
            categoryList.clear();
            idCategoryList.clear();
            for (int i = 0; i < response.data.length; i++) {
              var data = response.data[i];
              categoryList.add(data['categoryName'].toString());
              idCategoryList.add(data['id']);
            }
            emit(NodeParametrsState(id: state.id, nodeTitle: state.nodeTitle, nodeDescription: state.nodeDescription,createDate: state.createDate,updateDate: state.updateDate,isDeleted: false,categoryNameList: categoryList,idCategoryList: idCategoryList, idCategory: state.idCategory));
          }
  }

  Future<void> getNodeParametrs(int id)async{
    try{
      var response = await dio.get('/node/'+id.toString());
      var data = Node.fromJson(response.data);
      if(response.statusCode == 200){
          int categoryid = response.data['category']['id'];
          emit(NodeParametrsState(id: data.id, nodeTitle: data.nodeTitle, nodeDescription: data.nodeDescription,createDate: data.createDate,updateDate: data.updateDate,isDeleted: false,categoryNameList: [],idCategoryList: [], idCategory: categoryid));
        
      }
    } on DioError catch(e){
    }
  }

  

  
}