

import 'package:flutter/cupertino.dart';

class Utils {
  BuildContext context;

  Utils(@required this.context);

  double getMediaWidth() {
    return MediaQuery.of(context).size.width;
  }

  double getMediaHeight() {
    return MediaQuery.of(context).size.height;
  }




}
