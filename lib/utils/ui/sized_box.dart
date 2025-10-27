import 'package:flutter/cupertino.dart';

extension IntX on int {
  Widget get heightBox => SizedBox(height: toDouble());

  Widget get widthBox => SizedBox(width: toDouble());
}
