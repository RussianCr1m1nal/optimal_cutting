import 'package:flutter/material.dart';

class MainMenuItemModel {
  final String path;
  final IconData icon;
  final String Function(BuildContext context) buildTitle;
  final void Function(BuildContext context) onTab;

  MainMenuItemModel({
    required this.path,
    required this.buildTitle,
    required this.icon,
    required this.onTab,
  });
}
