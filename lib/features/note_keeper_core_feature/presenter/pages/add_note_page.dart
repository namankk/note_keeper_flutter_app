import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper_flutter_app/core/routes/routes.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/data/models/note_model.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/add_note_page_cubit/add_note_page_cubit.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/add_note_page_cubit/add_note_page_events.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/add_note_page_cubit/add_note_page_states.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/drop_down_cubit/DropDownEvents.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/drop_down_cubit/DropDownStates.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/drop_down_cubit/drop_down_cubit.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = "";
    String description = "";

    return Scaffold(
      appBar: AppBar(title: const Text("Add Note")),
      body: BlocConsumer<AddNotePageCubit, AddNotePageStates>(
          builder: (context, states) {
        if (states is AddNotePageInitialState) {
          return Form(child: BlocBuilder<DropDownCubit, DropDownStatesBase>(
              builder: (context, statesDrop) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: DropdownButton(
                        value: statesDrop.dropDownvalue,
                        items: statesDrop.items
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
                  ),
                  TitleAndDescriptionWidget(
                      titleValue: (String titleValue) {
                        title = titleValue;
                      },
                      validatorTitle: (value) {
                        return "some";
                      },
                      hintTitle: "Enter Note Title",
                      descriptionValue: (String desc) {
                        description = desc;
                      },
                      validatorDesc: (value) {
                        return "some";
                      },
                      hintDesc: "Enter Note Description"),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: ButtonBar(
                      mainAxisSize: MainAxisSize.max,
                      alignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AddNotePageCubit>()
                                  .mapEventsWithStates(
                                      AddNotePageEvent.onSaveButtonScreenEvent,
                                      noteModel: NoteModel(
                                          title: title,
                                          priority: statesDrop.dropDownvalue,
                                          date: DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString(),
                                          description: description));
                            },
                            child: const Text("Save")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AddNotePageCubit>()
                                  .mapEventsWithStates(AddNotePageEvent
                                      .onCloseButtonScreenEvent);
                            },
                            child: const Text("Cancel"))
                      ],
                    ),
                  )
                ],
              ),
            );
          }));
        } else if (states is AddNotePageLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text("Something went wrong"));
        }
      }, listenWhen: (oldState, newStates) {
        if (newStates is AddNotePageSaveButtonTappedState ||
            newStates is AddNotePageCloseButtonTappedState) {
          return true;
        } else {
          return false;
        }
      }, listener: (context, states) {
        if (states is AddNotePageSaveButtonTappedState ||
            states is AddNotePageCloseButtonTappedState) {
          goRoute.pop();
        }
      }),
    );
  }
}

typedef TextChange = Function(String value);
typedef ValidatorTitle = String? Function(String? value);
typedef ValidatorDesc = String? Function(String? value);

class TitleAndDescriptionWidget extends StatefulWidget {
  final TextChange _titleValue;
  final TextChange _descriptionValue;
  final ValidatorTitle _validatorTitle;
  final ValidatorDesc _validatorDesc;
  final String _hintTitle;
  final String _hintDesc;

  const TitleAndDescriptionWidget(
      {required TextChange titleValue,
      required TextChange descriptionValue,
      required ValidatorTitle validatorTitle,
      required ValidatorDesc validatorDesc,
      required String hintTitle,
      required String hintDesc,
      Key? key})
      : _titleValue = titleValue,
        _descriptionValue = descriptionValue,
        _validatorTitle = validatorTitle,
        _validatorDesc = validatorDesc,
        _hintTitle = hintTitle,
        _hintDesc = hintDesc,
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
          validator: widget._validatorTitle,
          decoration: InputDecoration(hintText: widget._hintTitle),
        ),
        TextFormField(
          controller: textDescriptionEditingController,
          validator: widget._validatorDesc,
          decoration: InputDecoration(hintText: widget._hintDesc),
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
