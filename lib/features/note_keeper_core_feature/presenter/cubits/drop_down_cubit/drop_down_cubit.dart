import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/drop_down_cubit/DropDownStates.dart';

class DropDownCubit extends Cubit<DropDownStatesBase> {
  DropDownCubit() : super(DropDownOnStateChange("0"));

  void onElementSelectedEvents(String? params) {
      emit(DropDownOnStateChange(params ?? "0"));
  }
}
