import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';

class SearchWidget extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final EdgeInsetsGeometry padding;
  final FocusNode focusNode;

  const SearchWidget({
    this.placeholder = "",
    required this.controller,
    this.onSubmitted,
    this.onChanged,
    required this.focusNode,
    this.padding = const EdgeInsets.all(16.0),
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SearchWidget();
}

class _SearchWidget extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: CupertinoTextField(
        textCapitalization: TextCapitalization.sentences,
        padding: const EdgeInsets.symmetric(vertical: 6.5, horizontal: 4),
        focusNode: widget.focusNode,
        autofocus: false,
        controller: widget.controller,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.grey.withOpacity(0.25),
        ),
        prefix: GestureDetector(
          onTap: () {
            if (widget.controller.text.isNotEmpty) {
              widget.controller.text = "";
              widget.onChanged?.call("");
              widget.focusNode.unfocus();
              setState(() {});
            } else {
              setState(() {});
              widget.focusNode.requestFocus();
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              widget.controller.text.isNotEmpty ? Icons.clear : Icons.search,
              size: 24,
              color: AppColors.grey,
            ),
          ),
        ),
        autocorrect: false,
        cursorWidth: 1,
        cursorHeight: 19,
        cursorColor: AppColors.black,
        cursorRadius: const Radius.circular(0),
        placeholder: widget.placeholder,
        placeholderStyle: const TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            height: 19 / 14,
            letterSpacing: -.02,
            fontFeatures: [
              FontFeature.enable("tnum"),
              FontFeature.enable("lnum"),
              FontFeature.enable("cv11"),
            ]),
        style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            height: 19 / 14,
            letterSpacing: -.02,
            fontFeatures: [
              FontFeature.enable("tnum"),
              FontFeature.enable("lnum"),
              FontFeature.enable("cv11"),
            ]),
        onChanged: (text) {
          widget.onChanged?.call(text);
          setState(() {});
        },
        onSubmitted: (text) {
          widget.onSubmitted?.call(text);
        },
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
