import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_keeper_flutter_app/core/extensions/extension_base.dart';
import 'package:note_keeper_flutter_app/core/routes/route_names.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/home_page_bloc/home_page_events.dart';

import '../cubits/home_page_bloc/home_page_bloc.dart';
import '../cubits/home_page_bloc/home_page_states.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(100, 150),
          child: Container(
            color: Colors.purple.shade800,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(80.0)),
              ),
              padding: const EdgeInsets.only(left: 30, bottom: 40, top: 50),
              child: const Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.accessibility_sharp),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "NoteKeeper",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )),
      body:
          const ListOfNotesWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(RouteNames.addNote);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ListOfNotesWidget extends StatelessWidget {
  const ListOfNotesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageStates>(builder: (context, state) {
        return switch (state) {
    HomePageLoadingStates() => const Center(
        child: CircularProgressIndicator(),
      ),
    HomePageEmptyStates() => SizedBox.expand(
        child: Container(
            color: Colors.purple.shade800,
            child: Center(
                child: Text(
              "No Data to show please add some data",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ))),
      ),
    HomePageErrorStates() => const Center(
        child: Text("Error Something went wrong"),
      ),
    HomePageSuccessStates() => ListView.builder(
        itemBuilder: (context, index) {
          final noteEntity = state.data[index];
          return Container(
            color: index == state.data.length - 1
                ? Colors.white
                : index.isOdd
                    ? Colors.purple.shade800
                    : Colors.purple.shade200,
            child: Container(
              decoration: BoxDecoration(
                color: index.isOdd
                    ? Colors.purple.shade200
                    : Colors.purple.shade800,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(80.0)),
              ),
              padding:
                  const EdgeInsets.only(left: 30, bottom: 70, top: 40),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${noteEntity.date.date.getWeekDateName()} ${noteEntity.date.date.day} ${noteEntity.date.date.getMonthName()}",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12.0),
                      ),
                      Text(
                        noteEntity.title,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 22.0),
                      ),
                      Text(
                        "Priority ${noteEntity.priority == "1" ? "High" : "Low"}",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 22.0),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 20,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Transform.rotate(
                        angle: 170,
                        child: IconButton(
                            color: Colors.white,
                            iconSize: 40,
                            onPressed: () {
                              context
                                  .read<HomePageBloc>()
                                  .add(OnDeleteButtonTap(noteEntity.id!));
                            },
                            icon: const Icon(Icons.delete_forever)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: state.data.length),
        };
      });
  }
}
