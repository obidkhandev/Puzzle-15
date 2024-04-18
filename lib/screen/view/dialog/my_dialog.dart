import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller.dart';

void showCongratulationsDialog(RxInt elapsedTime,RxInt moveCount,) {
  final PuzzleController controller = Get.put(PuzzleController());
  Get.dialog(
    AlertDialog(
      title: const Text("Tabriklaymiz!"),
      content: Text("Siz ${elapsedTime.value} soniyada va ${moveCount.value} urinishda o'yinni muvaffaqiyatli tugatdingiz."),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
            controller.resetGame();
          },
          child: const Text('Yana oynash'),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}