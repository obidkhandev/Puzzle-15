import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puzzle_15/screen/view/dialog/my_dialog.dart';

class PuzzleController extends GetxController {
  int gridSize = 4;
  RxList<int> tiles = List<int>.generate(16, (index) => index + 1).obs;
  Timer? timer;
  RxBool gameEnded = false.obs;
  RxInt elapsedTime = 0.obs;
  RxInt moveCount = 0.obs;
  RxInt color = Colors.lightBlue.value.obs;



  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedTime.value++;
    });
  }

  void randomColor() {
    List<int> colors = [
      Colors.teal.value,
      Colors.deepPurple.value,
      Colors.red.value,
      Colors.deepOrange.value,
      Colors.greenAccent.value,
      Colors.indigo.value,
      Colors.greenAccent.value,
    ];
    color.value = colors[Random().nextInt(colors.length)];
  }



  void shuffleTiles() {
    var random = Random();
    tiles.shuffle(random);
    tiles.refresh();
    if (isSolved()) {
      shuffleTiles();
    }
  }

  bool isSolved() {
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i + 1) return false;
    }
    return true;
  }

  void moveTile(int index) {
    int zeroIndex = tiles.indexOf(16);
    if (zeroIndex == index) return;

    int row = index ~/ gridSize;
    int column = index % gridSize;
    int zeroRow = zeroIndex ~/ gridSize;
    int zeroColumn = zeroIndex % gridSize;

    if ((row == zeroRow && (column == zeroColumn + 1 || column == zeroColumn - 1)) ||
        (column == zeroColumn && (row == zeroRow + 1 || row == zeroRow - 1))) {
      tiles[zeroIndex] = tiles[index];
      tiles[index] = 16;
      moveCount.value++;
      tiles.refresh();

      if (isSolved()) {
        gameEnded.value = true;
        timer?.cancel();
        showCongratulationsDialog(elapsedTime,moveCount);
      }
    }
  }

  void resetGame() {
    shuffleTiles();
    gameEnded.value = false;
    elapsedTime.value = 0;
    moveCount.value = 0;
    timer?.cancel();
    startTimer();
  }


}
