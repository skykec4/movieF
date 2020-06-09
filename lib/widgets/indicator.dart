import 'package:flutter/material.dart';

import '../utils/constant.dart';

class Indicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Theme(
            data: Theme.of(context).copyWith(
                accentColor: Constant.mainThreeColor),
            child: CircularProgressIndicator()));
  }
}
