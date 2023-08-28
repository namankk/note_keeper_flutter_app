import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_keeper_flutter_app/core/routes/route_names.dart';
import 'package:note_keeper_flutter_app/core/utils/app_color.dart';

import '../cubits/home_page_bloc/home_page_bloc.dart';
import '../cubits/home_page_bloc/home_page_states.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NoteKeeper",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColor.searchBgColor,
            ),
            height: 30,
            width: MediaQuery.sizeOf(context).width,
            margin: const EdgeInsets.only(top: 30.0),
          ),
          const Expanded(child: ListOfNotesWidget()),
        ],
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

class ListOfNotesWidget extends StatelessWidget {
  const ListOfNotesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageStates>(builder: (context, state) {
      return Container(
        padding: const EdgeInsets.all( 10.0),
        child: switch (state) {
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
          HomePageSuccessStates() => GridView.builder(
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10.0,mainAxisSpacing: 10.0),
              itemBuilder: (context, index) {
                final noteEntity = state.data[index];
                return Container(
                  decoration:  BoxDecoration(
                    color: AppColor.boxColor1,
                    boxShadow: kElevationToShadow[1],
                    borderRadius: const BorderRadius.all(
                         Radius.circular(16.0)),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        noteEntity.title,
                        style: GoogleFonts.alatsi(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        noteEntity.description,
                        style: GoogleFonts.alatsi(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),

                    ],
                  ),
                );
              },
              itemCount: state.data.length,
            )
        },
      );
    });
  }
}
