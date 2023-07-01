import 'package:note_keeper_flutter_app/features/note_keeper_core_feature/domain/entities/dropdown_entity.dart';

abstract class DropDownStatesBase {
  // Initial Selected Value
  String dropDownvalue = '0';

  // List of items in our dropdown menu
  List<DropDownEntity> items = [
    DropDownEntity(key: "0", value: "High"),
    DropDownEntity(key: "1", value: "Low"),
  ];
}

class DropDownOnStateChange extends DropDownStatesBase {
  late final String _selectedItem;

  DropDownOnStateChange(String itemIndex) {
    _selectedItem = itemIndex;
    dropDownvalue = _selectedItem;
  }

  String get itemIndex => _selectedItem;
}
