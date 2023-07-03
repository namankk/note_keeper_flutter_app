import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:go_router/go_router.dart';
import 'package:note_keeper_flutter_app/core/routes/route_names.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_cubit/home_page_states.dart';

import '../cubits/home_page_cubit/home_page_events.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () {
        context
            .read<HomePageCubit>()
            .mapEventWithStates(HomePageEvents.onInitializeScreen);
      },
      child: Scaffold(
        appBar: PreferredSize(child: Container(
           color : Colors.pink.shade400,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // color : Color.fromRGBO(64, 18, 139, 1),
              // gradient : LinearGradient(
              //     begin: Alignment(6.123234262925839e-17,1),
              //     end: Alignment(-1,6.123234262925839e-17),
              //     colors: [Color.fromRGBO(221, 88, 214, 1),Color.fromRGBO(221, 88, 214, 0)]
              // ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80.0)),
            ),
            padding: EdgeInsets.only(left: 30,bottom: 40,top: 50),
            child: Row(
              children: [
                CircleAvatar(child: Icon(Icons.accessibility_sharp),),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("NoteKeeper",style: TextStyle(color: Colors.black,fontSize: 22.0,fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ),
        ), preferredSize: Size(100,150)),
        body: BlocConsumer<HomePageCubit, HomePageStates>(
            buildWhen: (old, states) {
          return (states is! HomePageShowSnakeBar);
        }, builder: (context, state) {
          if (state is HomePageLoadingStates) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomePageEmptyStates) {
            return const Center(
              child: Text("No Data to show please add some data"),
            );
          } else if (state is HomePageErrorStates) {
            return const Center(
              child: Text("Error Something went wrong"),
            );
          } else if (state is HomePageSuccessStates) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  final noteEntity=state.data[index];
                  return  Container(
                    color: index.isOdd?Colors.pink.shade400:Colors.purple.shade800,
                    child: Container(
                     decoration: BoxDecoration(
                       color: index.isOdd?Colors.purple.shade800:Colors.pink.shade400,
                           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80.0)),
                     ),
                      padding: EdgeInsets.only(left: 30,bottom: 70,top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(decoration:  BoxDecoration(
                          //   borderRadius: BorderRadius.circular(20.0),
                          //   border: Border.all(color: noteEntity.priority=="0"?Theme.of(context).primaryColorLight:Theme.of(context).primaryColor),
                          //   color: noteEntity.priority=="0"?Theme.of(context).primaryColorLight:Theme.of(context).primaryColor,
                          // ),child: Text(noteEntity.priority=="0"?"L":"H"),),
                          Text(noteEntity.date,style: TextStyle(color: Colors.white,fontSize: 12.0),),
                          Text(noteEntity.title,style: TextStyle(color: Colors.white,fontSize: 22.0),),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: IconButton(onPressed: () {
                          //     context.read<HomePageCubit>().mapEventWithStates(HomePageEvents.onDeleteTapped,id: noteEntity.id);
                          //   },
                          //   icon: const Icon(Icons.delete)),
                          // ),
                        ],
                      ),
                    ),
                  );
                },

                itemCount: state.data.length);
          } else {
            return const Center(child: Text("No State found"));
          }
        }, listenWhen: (previousState, newState) {
          if (newState is HomePageShowSnakeBar) {
            return true;
          } else {
            return false;
          }
        }, listener: (context, homePageState) {
          if (homePageState is HomePageShowSnakeBar) {
            print("HomePageShowSnakeBar called ");
            context.goNamed(RouteNames.addNote);
          }
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context
                .read<HomePageCubit>()
                .mapEventWithStates(HomePageEvents.onTileTapped);
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
