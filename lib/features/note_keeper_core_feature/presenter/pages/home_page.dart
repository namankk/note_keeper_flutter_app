import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_cubit.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_states.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/widgets/common_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("NoteKeeper"),
      ),
      body: BlocBuilder<HomePageCubit,HomePageStates>(builder: (context,state){
        if(state is HomePageLoadingStates){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else if(state is HomePageEmptyStates){
          return const Center(
            child: Text("No Data to show please add some data"),
          );
        }else if(state is HomePageErrorStates){
          return const Center(
            child: Text("Error Something went wrong"),
          );
        }else if(state is HomePageSuccessStates){
          return ListView.separated(itemBuilder: (context,index){
            return noteTileWidget(state.data[index]);
          }, separatorBuilder: (context,index){
            return const SizedBox(height: 20.0,);
          }, itemCount: state.data.length);
        }else{
          return const Center(child: Text("No State found"));
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
