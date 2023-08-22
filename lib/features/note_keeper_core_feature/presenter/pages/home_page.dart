import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_keeper_flutter_app/core/extensions/extension_base.dart';
import 'package:note_keeper_flutter_app/core/routes/route_names.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/use_cases/show_list_use_case.dart';
import 'package:note_keeper_flutter_app/core/service_locator/service_locator.dart'
    as service_locator;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myUseCase = service_locator.sl<ShowListUseCase>();
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
      body: StreamBuilder(
        stream: myUseCase.showStreamOfNotes(),
        builder:
            (BuildContext context, AsyncSnapshot<List<NoteEntity>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  final noteEntity = snapshot.data![index];
                  return Container(
                    color: index == snapshot.data!.length - 1
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
                                      myUseCase.deleteElements(noteEntity.id!);
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
                itemCount: snapshot.data?.length);
          } else {
            return SizedBox.expand(
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
            );
          }
        },
      ),
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
