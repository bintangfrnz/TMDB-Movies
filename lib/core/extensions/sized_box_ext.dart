import 'package:flutter/material.dart';

extension SizedBoxExt on double {
  SizedBox get height => SizedBox(height: this);
  SizedBox get width => SizedBox(width: this);
}
