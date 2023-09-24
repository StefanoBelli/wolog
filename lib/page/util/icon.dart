import 'package:flutter/material.dart';

import '../../repository.dart';

final _iconPath = {};

dynamic buildIconFromName(final String? iconName) {
  if(iconName == null) {
    return const Icon(Icons.question_mark);
  }

  return ImageIcon(
    Image.asset('asset/${_iconPath[iconName]}').image);
}


Future<void> preloadIconPaths() async {
  final iconModels = await Repository().fetchAllIcons();

  for(final iconModel in iconModels) {
    _iconPath[iconModel.name] = iconModel.filename;
  } 
}