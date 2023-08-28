import 'dart:math';
import 'dart:ui';

import 'package:note_keeper_flutter_app/core/utils/app_color.dart';

Color getRandomColor(){
  List<Color> colorList=[AppColor.boxColor2,AppColor.boxColor3,AppColor.boxColor4,
    AppColor.boxColor5,AppColor.boxColor6];
  return colorList.elementAt(Random().nextInt(colorList.length-1));
}