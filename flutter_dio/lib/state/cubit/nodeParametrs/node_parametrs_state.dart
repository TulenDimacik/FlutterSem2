class NodeParametrsState {
  final int id;
  final String nodeTitle;
   final String nodeDescription;
    final String createDate;
    final String updateDate;
    final bool isDeleted;
    final int idCategory;

  final List<String> categoryNameList;
  final List idCategoryList;

  const NodeParametrsState({required this.id, required this.nodeTitle, required this.nodeDescription,required this.createDate, required this.updateDate, required this.isDeleted, required this.idCategory, required this.categoryNameList, required this.idCategoryList});
}

