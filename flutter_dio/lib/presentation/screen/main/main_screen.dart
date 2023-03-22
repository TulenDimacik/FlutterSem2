import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dio/presentation/screen/main_children/node_data.dart';
import 'package:flutter_dio/presentation/screen/main_children/profile.dart';
import 'package:flutter_dio/state/cubit/nodeList/node_list_cubit.dart';
import 'package:flutter_dio/state/cubit/nodeList/node_list_state.dart';
import '../../widgets/cutom_search_delegate.dart';
import '../auth/sign_in.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  
  static const routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int currentIndex = 0;
  final listPage = [NodeData(),Profile(),];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Финансы"),
      actions: [
        IconButton(onPressed: ()
        {
          List a = context.read<NodeListCubit>().state.nodeNameList;
          CustomSearchDelegate st = CustomSearchDelegate();
          st.searchTerms = a;
          showSearch(context: context, delegate: st);
        }, 
        icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap:(index){
          setState((){
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label:'Заметки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label:'Профиль'
          )
        ]
      ),
      body: listPage[currentIndex],
    );
  }
}