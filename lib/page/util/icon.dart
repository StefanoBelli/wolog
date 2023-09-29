import 'package:flutter/material.dart';

import '../../model/icon.dart';
import '../../repository.dart';

final _iconPath = {};

Container buildIconFromName(final String? iconName, {final double sqSize = 100}) {
  dynamic icon;

  if(iconName == null) {
    icon = Icon(Icons.question_mark, size: sqSize);
  } else {
    icon = ImageIcon(
        Image.asset('asset/${_iconPath[iconName]}').image, size: sqSize,);
  }

  return Container(
      width: sqSize,
      height: sqSize,
      alignment: Alignment.center,
      child: icon);
}

Future<void> preloadIconPaths() async {
  final iconModels = await Repository().fetchAllIcons();

  for(final iconModel in iconModels) {
    _iconPath[iconModel.name] = iconModel;
  } 
}

IconModel getIconModelByName(final String name) =>
  _iconPath[name];