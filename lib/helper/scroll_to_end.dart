import 'package:flutter/material.dart';

void scrollToEnd(ScrollController scrollController) {
  if (!scrollController.hasClients) return;
  scrollController.animateTo(0,
      duration: Duration(milliseconds: 300), curve: Curves.easeOut);
}
