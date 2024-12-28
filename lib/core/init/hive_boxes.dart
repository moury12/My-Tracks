import 'package:hive_flutter/hive_flutter.dart';
import 'package:track_trek/core/global/string_variable.dart';

class Boxes{
  static Box getUserData()=>Hive.box(userBoxName);

}