import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/note_detail_page_cubit/note_detail_page_cubit.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/note_detail_page_cubit/note_detail_page_states.dart';

class NoteDetailPage extends StatelessWidget {
  final String _className;

  const NoteDetailPage(this._className, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_className)),
      body: BlocConsumer<NoteDetailPageCubit, NoteDetailPageStates>(
          builder: (context, states) {
            if (states is NoteDetailPageInitialState) {
              return Column(
                children: [
                  Form(child: Column(
                    children: [
                      TextFormField(),
                      TextFormField(),
                    ],
                  )),
                  ButtonBar(
                    children: [
                      ElevatedButton(onPressed: (){}, child: Text("Save")),
                      ElevatedButton(onPressed: (){}, child: Text("Cancel"))
                    ],
                  )
                ],
              );
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          }, listener: (context, states) {}),
    );
  }
}
