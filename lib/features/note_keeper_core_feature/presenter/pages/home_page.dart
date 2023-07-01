import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_keeper_flutter_app/core/routes/route_names.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_cubit/home_page_states.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/widgets/common_widgets.dart';

import '../cubits/home_page_cubit/home_page_events.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("NoteKeeper"),
      ),
      body: BlocConsumer<HomePageCubit, HomePageStates>(
          buildWhen: (old, states) {
            return (states is! HomePageShowSnakeBar);
          },
          builder: (context, state) {
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
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return noteTileWidget(state.data[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20.0,
                    );
                  },
                  itemCount: state.data.length);
            } else {
              return const Center(child: Text("No State found"));
            }
          },
          listenWhen: (previousState,newState){
            if(newState is HomePageShowSnakeBar){
              return true;
            }else{
              return false;
            }
          },
          listener: (context, homePageState) {
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
    );
  }
}
