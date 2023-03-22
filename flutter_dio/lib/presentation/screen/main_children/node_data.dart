import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dio/node.dart';
import 'package:flutter_dio/state/cubit/nodeList/node_list_cubit.dart';
import 'package:flutter_dio/state/cubit/nodeList/node_list_state.dart';
import 'package:flutter_dio/state/cubit/nodeParametrs/node_parametrs_cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_field_obscure.dart';
import '../auth/sign_in.dart';

class NodeData extends StatefulWidget {
  const NodeData({super.key});

  static const routeName = '/finance';

  @override
  State<NodeData> createState() => _NodeData();
}

class _NodeData extends State<NodeData> {
  String dropdownValue = '';
  List<String> categoryList = [];
  String screenTitle = '';

  GlobalKey<FormState> _key = GlobalKey();

  TextEditingController _nodeTitle = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _createDate = TextEditingController();
  TextEditingController _updateDate = TextEditingController();
  TextEditingController _isDeletedController = TextEditingController();
  TextEditingController _idCategoryController = TextEditingController();
  TextEditingController _dropdownController = TextEditingController();
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                context.read<NodeParametrsCubit>().logicalReturn().then(
                    (value) =>
                        context.read<NodeListCubit>().getNodeList());
              });
            },
            child: const Text("Логиеское восстановление")),
        ElevatedButton(
            onPressed: () {
              setState(() {
                showAddScreen();
                /*SimpleDialog(
                          children: [
                            const Spacer(),
                            const Text(
                              'Добавление',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 26),
                            ),
                            const Spacer(),
                            TextFormField(
                              controller: _nodeTitle,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Поле названия оперции пустое';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Наименование операции',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _descriptionController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Поле описания пустое';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Описание',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _updateDate,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Поле суммы операции пустое';
                                }
                                return null;
                              },
                              obscureText: isObscure,
                              decoration: InputDecoration(
                                hintText: 'Сумма',
                                suffixIcon:
                                    TextFieldObscure(isObscure: (value) {
                                  setState(() {
                                    isObscure = value;
                                  });
                                }),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _createDate,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Поле даты пустое';
                                }
                                return null;
                              },
                              obscureText: isObscure,
                              decoration: InputDecoration(
                                hintText: 'Дата',
                                suffixIcon:
                                    TextFieldObscure(isObscure: (value) {
                                  setState(() {
                                    isObscure = value;
                                  });
                                }),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                                content: 'Добавить',
                                onPressed: () {
                                  ADDNode();
                                }),
                            const Spacer(flex: 3),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(15),
                                ),
                                child: const Icon(Icons.arrow_back,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        )));*/
              });
            },
            child: const Text("Добавить")),
        Expanded(
          child: SizedBox(
              height: 500.0,
              child: BlocConsumer<NodeListCubit, NodeListState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: state.nodeNameList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      context
                                          .read<NodeListCubit>()
                                          .deleteFromNodeList(index);
                                    });
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showUpdateScreen(index);
                                    });
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<NodeParametrsCubit>()
                                        .logicalDelete(context
                                            .read<NodeListCubit>()
                                            .getID(index))
                                        .then(
                                          (value) => context
                                              .read<NodeListCubit>()
                                              .getNodeList(),
                                        );
                                  },
                                  icon: Icon(Icons.visibility_off),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Text('${state.nodeNameList[index]}'),
                                ),
                              ]);
                        });
                  })),
        ),
      ],
    );
  }

  void getNode() async {
    context.read<NodeListCubit>().getNodeList();
  }

  void UPDNode(int index) async {
    context
        .read<NodeParametrsCubit>()
        .updateNodeParametrs(Node(
            id: context.read<NodeParametrsCubit>().state.id,
            nodeTitle: _nodeTitle.text,
            nodeDescription: _descriptionController.text,
            createDate: _createDate.text,
            updateDate: _updateDate.text,
            isDeleted: false,
            idCategory: context
                .read<NodeParametrsCubit>()
                .getIDCategoryFromName(dropdownValue)))
        .then((value) => context
            .read<NodeListCubit>()
            .updateNodeList(index, _nodeTitle.text));
            SnackBar(
          content: Text('Успешное обновление заметки '),
        );
  }

  void ADDNode() async {
    context
        .read<NodeParametrsCubit>()
        .addNode(Node(
            id: 0,
            nodeTitle: _nodeTitle.text,
            nodeDescription: _descriptionController.text,
            createDate: _createDate.text,
            updateDate: _updateDate.text,
            isDeleted: false,
            idCategory: context
                .read<NodeParametrsCubit>()
                .getIDCategoryFromName(dropdownValue)))
        .then((value) => context.read<NodeListCubit>().getNodeList());
        SnackBar(
          content: Text('Успешное добавление заметки '),
        );
  }

  void showUpdateScreen(int index) async {
    // await context.read<ListCubit>().getID(index);
    int id = await context.read<NodeListCubit>().getID(index);
    await context
        .read<NodeParametrsCubit>()
        .getNodeParametrs(id)
        .then((value) => context.read<NodeParametrsCubit>().getCategories());
    _nodeTitle.text =
        context.read<NodeParametrsCubit>().state.nodeTitle;
    _descriptionController.text =
        context.read<NodeParametrsCubit>().state.nodeDescription;
    _createDate.text =
        context.read<NodeParametrsCubit>().state.createDate.toString();
    _updateDate.text =
        context.read<NodeParametrsCubit>().state.updateDate.toString();
    _changeGrade(context.read<NodeParametrsCubit>().getCategoryFromID(
        context.read<NodeParametrsCubit>().state.idCategory));
    categoryList = context.read<NodeParametrsCubit>().state.categoryNameList;
    screenTitle = 'Просмотр-Редактирование';
   // dropdownValue = context.read<NodeParametrsCubit>().getCategoryFromID(context.read<NodeParametrsCubit>().state.idCategory);
    showDialog(
      context: context,
      builder: (context) => gradeDialog(index),
    );
  }

  void showAddScreen() async {
    _nodeTitle.text ='';
    _descriptionController.text ='';
    _createDate.text ='';
    _updateDate.text ='';
    await context.read<NodeParametrsCubit>().getCategories();
    categoryList = context.read<NodeParametrsCubit>().state.categoryNameList;
    //_changeGrade('Ипотека');
    screenTitle = 'Добавление';
    dropdownValue = context.read<NodeParametrsCubit>().state.categoryNameList[0];
                showDialog(
      context: context,
      builder: (context) => gradeDialog(-1),
    );
  }

  void _changeGrade(_newGrade) {
    setState(
      () {
        dropdownValue = _newGrade;
      },
    );
  }

  StatefulBuilder gradeDialog(int index) {
    return StatefulBuilder(
      builder: (context, _setter) {
        return SimpleDialog(
          children: [
            const Spacer(),
            const Text(
              'Заметки',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26),
            ),
            const Spacer(),
            TextFormField(
              controller: _nodeTitle,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле названия заметки';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Наименование заметки',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле описания заметки';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Описание',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _updateDate,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле даты изменения пустое';
                }
                return null;
              },
              obscureText: isObscure,
              decoration: InputDecoration(
                hintText: 'Дата изменения',
                suffixIcon: TextFieldObscure(isObscure: (value) {
                  setState(() {
                    isObscure = value;
                  });
                }),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _createDate,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле даты создания пустое';
                }
                return null;
              },
              obscureText: isObscure,
              decoration: InputDecoration(
                hintText: 'Дата создания',
                suffixIcon: TextFieldObscure(isObscure: (value) {
                  setState(() {
                    isObscure = value;
                  });
                }),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(height: 30),
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? _newGrade) {
                _setter(
                  () {
                    dropdownValue = _newGrade!;
                  },
                );
                _changeGrade(_newGrade);
              },
              items: categoryList.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 20),
            CustomButton(
                content: 'Сохранить',
                onPressed: () {
                  if(index != -1)
                    UPDNode(index);
                  else
                    ADDNode();
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }
}
