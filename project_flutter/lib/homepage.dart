// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_flutter/barrier.dart';
import 'package:project_flutter/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Variables
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.5;
  double velocity = 2;
  double birdWidth = 0.1;
  double birdHeight = 0.1;

  bool gameStarted = false;

  static List<double> barrierX = [0.5, 0.5 + 1.5];
  static double barrierWidth = 0.1;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  //Fonction jump
  void startGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      height = gravity * time * time + velocity * time;

      setState(() {
        birdY = initialPos - height;
      });

      if (birdIsDead()) {
        timer.cancel();
        _showDialog();
      }

      moveMap();

      time += 0.01;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.005;
      });

      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
      }
    }
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool birdIsDead() {
    if (birdY < -1 || birdY > 1) return true;

    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] < birdWidth / 4 &&
          barrierX[i] + barrierWidth > -birdWidth / 4 &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }

    return false;
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameStarted = false;
      time = 0;
      initialPos = birdY;
      barrierX = [0.5, 0.5 + 1.5];
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                "G A M E  O V E R",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(17),
                    color: Colors.white,
                    child: Text(
                      'PLAY AGAIN',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: gameStarted ? jump : startGame,
        child: Scaffold(
          body: Column(children: [
            Expanded(
              flex: 6,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      MyBird(
                        birdY: birdY,
                        birdWidth: birdWidth,
                        birdHeight: birdHeight,
                      ),
                      Container(
                        alignment: Alignment(0, -0.5),
                        child: Text(
                          gameStarted ? '' : 'T A P  T O  P L A Y',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ),
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[0][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[0][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarrier(
                        barrierX: barrierX[1],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[1][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarrier(
                        barrierX: barrierX[1],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[1][1],
                        isThisBottomBarrier: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.brown,
              ),
            ),
          ]),
        ));
  }
}
