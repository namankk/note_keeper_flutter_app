import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_keeper_flutter_app/core/routes/route_names.dart';
import 'package:note_keeper_flutter_app/core/utils/app_color.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/note_entity.dart';

import '../cubits/home_page_bloc/home_page_bloc.dart';
import '../cubits/home_page_bloc/home_page_events.dart';
import '../cubits/home_page_bloc/home_page_states.dart';
import '../widgets/common_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NoteKeeper",
          style: TextStyle(
              color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          SearchWidget(),
          Expanded(child: MainView()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.addNoteColor,
        onPressed: () {
          context.goNamed(RouteNames.addNote);
        },
        shape: const CircleBorder(),
        tooltip: 'Add Note',
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: 20.0, left: 10.0, right: 10.0, bottom: 20.0),
      padding: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          decoration: const BoxDecoration(
              color: AppColor.searchBgColor,
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: TextField(
            minLines: 1,
            maxLines: 1,
            onChanged: (string) {
              context.read<HomePageBloc>().add(OnSearchChange(string));
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: AppColor.searchTextColor),
              fillColor: AppColor.searchTextColor,
              focusColor: AppColor.searchTextColor,
              hintText: "Search for notes",
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              border: InputBorder.none,
              hintStyle: GoogleFonts.manrope(
                  fontSize: 14, color: AppColor.searchTextColor),
            ),
            style: GoogleFonts.manrope(
                fontSize: 14, color: AppColor.searchTextColor),
          ),
        ),
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageStates>(
        builder: (context, state) => switch (state) {
              HomePageLoadingStates() => const LoadingWidget(),
              HomePageEmptyStates() => const EmptyWidget(),
              HomePageEmptyFilterStates() => const NoResultFoundWidget(
                  imagePath: "lib/core/assets/filter.svg",
                  titleText: "Ups!... no results found",
                  descText: "Please try another search"),
              HomePageErrorStates() => const NoResultFoundWidget(
                  imagePath: "lib/core/assets/something.svg",
                  titleText: "Ups!... something went wrong!!"),
              HomePageSuccessStates() =>
                GridViewOfNotesWidget(newData: state.data)
            });
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Align(
          alignment: Alignment.center,
          child: Image.asset("lib/core/assets/add_note.jpg")),
    );
  }
}

class GridViewOfNotesWidget extends StatelessWidget {
  const GridViewOfNotesWidget({
    super.key,
    required this.newData,
  });

  final List<NoteEntity> newData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
      itemBuilder: (context, index) {
        final noteEntity = newData[index];
        return InkWell(
          onTap: () {
            context.goNamed(RouteNames.addNote, extra: noteEntity);
          },
          child: Container(
            decoration: BoxDecoration(
              color: noteEntity.color,
              boxShadow: kElevationToShadow[1],
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  noteEntity.title,
                  style: GoogleFonts.margarine(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: Text(
                    noteEntity.description,
                    style: GoogleFonts.manrope(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: newData.length,
    );
  }
}
