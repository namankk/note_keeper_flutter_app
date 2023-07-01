import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper_flutter_app/core/routes/routes.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/models/note_model.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/add_note_page_cubit/add_note_page_cubit.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/add_note_page_cubit/add_note_page_states.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/drop_down_cubit/DropDownEvents.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/drop_down_cubit/DropDownStates.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/drop_down_cubit/drop_down_cubit.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _title = "";
    String _description = "";

    return Scaffold(
      appBar: AppBar(title: const Text("Add Note")),
      body: BlocConsumer<AddNotePageCubit, AddNotePageStates>(
          builder: (context, states) {
        if (states is AddNotePageInitialState) {
          return Form(child: BlocBuilder<DropDownCubit, DropDownStatesBase>(
              builder: (context, states) {
            return Column(
              children: [
                DropdownButton(
                    value: states.dropDownvalue,
                    items: states.items
                        .map((entity) => DropdownMenuItem(
                              value: entity.key,
                              child: Text(entity.value),
                            ))
                        .toList(),
                    onChanged: (s) {
                      context.read<DropDownCubit>().mapStatesWithEvents(
                          DropDownEvents.onElementSelected,
                          params: s);
                    }),
                TitleAndDescriptionWidget(titleValue: (String title) {
                  _title = title;
                }, descriptionValue: (String description) {
                  _description = description;
                }),
                ButtonBar(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          context.read<AddNotePageCubit>().addNote(NoteModel(
                              title: _title,
                              priority: states.dropDownvalue,
                              date: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              description: _description));
                        },
                        child: Text("Save")),
                    ElevatedButton(onPressed: () {}, child: Text("Cancel"))
                  ],
                )
              ],
            );
          }));
        } else if (states is AddNotePageLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text("Something went wrong"));
        }
      }, listenWhen: (oldState, newStates) {
        if (newStates is AddNotePageSaveButtonTappedState) {
          return true;
        } else {
          return false;
        }
      }, listener: (context, states) {
        if (states is AddNotePageSaveButtonTappedState) {
          goRoute.pop();
        }
      }),
    );
  }
}

typedef TextChange = Function(String value);

class TitleAndDescriptionWidget extends StatefulWidget {
  final TextChange _titleValue;
  final TextChange _descriptionValue;

  const TitleAndDescriptionWidget(
      {required TextChange titleValue,
      required TextChange descriptionValue,
      Key? key})
      : _titleValue = titleValue,
        _descriptionValue = descriptionValue,
        super(key: key);

  @override
  State<TitleAndDescriptionWidget> createState() =>
      _TitleAndDescriptionWidgetState();
}

class _TitleAndDescriptionWidgetState extends State<TitleAndDescriptionWidget> {
  TextEditingController textTitleEditingController = TextEditingController();
  TextEditingController textDescriptionEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    textTitleEditingController.addListener(() {
      widget._titleValue(textTitleEditingController.text);
    });
    textDescriptionEditingController.addListener(() {
      widget._descriptionValue(textDescriptionEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        TextFormField(
          controller: textTitleEditingController,
        ),
        TextFormField(
          controller: textDescriptionEditingController,
        ),
      ],
    ));
  }

  @override
  void dispose() {
    textTitleEditingController.dispose();
    textDescriptionEditingController.dispose();
    super.dispose();
  }
}
