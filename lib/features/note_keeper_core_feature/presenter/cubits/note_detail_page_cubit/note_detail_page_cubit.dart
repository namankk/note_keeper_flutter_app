import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/presenter/cubits/note_detail_page_cubit/note_detail_page_states.dart';

class NoteDetailPageCubit extends Cubit<NoteDetailPageStates>{
  NoteDetailPageCubit():super(NoteDetailPageLoadingState());
}