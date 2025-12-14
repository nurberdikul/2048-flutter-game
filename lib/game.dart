import 'package:flutter/material.dart';
import 'dart:math';

class GamePage extends StatefulWidget {
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<List<int>> grid = List.generate(4, (_) => List.filled(4, 0));

  @override
  void initState() {
    super.initState();
    addRandomTile();
    addRandomTile();
  }

  void addRandomTile() {
    List<Point<int>> empty = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] == 0) empty.add(Point(i, j));
      }
    }
    if (empty.isNotEmpty) {
      var pos = empty[Random().nextInt(empty.length)];
      grid[pos.x][pos.y] = Random().nextInt(10) == 0 ? 4 : 2;
    }
  }

  void moveLeft() {
    setState(() {
      for (int i = 0; i < 4; i++) {
        List<int> newRow = grid[i].where((v) => v != 0).toList();
        for (int j = 0; j < newRow.length - 1; j++) {
          if (newRow[j] == newRow[j + 1]) {
            newRow[j] *= 2;
            newRow[j + 1] = 0;
          }
        }
        newRow = newRow.where((v) => v != 0).toList();
        while (newRow.length < 4) newRow.add(0);
        grid[i] = newRow;
      }
      addRandomTile();
    });
  }

  void moveRight() {
    setState(() {
      for (int i = 0; i < 4; i++) {
        List<int> newRow = grid[i].where((v) => v != 0).toList();
        for (int j = newRow.length - 1; j > 0; j--) {
          if (newRow[j] == newRow[j - 1]) {
            newRow[j] *= 2;
            newRow[j - 1] = 0;
          }
        }
        newRow = newRow.where((v) => v != 0).toList();
        while (newRow.length < 4) newRow.insert(0, 0);
        grid[i] = newRow;
      }
      addRandomTile();
    });
  }

  void moveUp() {
    setState(() {
      for (int j = 0; j < 4; j++) {
        List<int> col = [];
        for (int i = 0; i < 4; i++) if (grid[i][j] != 0) col.add(grid[i][j]);
        for (int i = 0; i < col.length - 1; i++) {
          if (col[i] == col[i + 1]) {
            col[i] *= 2;
            col[i + 1] = 0;
          }
        }
        col = col.where((v) => v != 0).toList();
        while (col.length < 4) col.add(0);
        for (int i = 0; i < 4; i++) grid[i][j] = col[i];
      }
      addRandomTile();
    });
  }

  void moveDown() {
    setState(() {
      for (int j = 0; j < 4; j++) {
        List<int> col = [];
        for (int i = 0; i < 4; i++) if (grid[i][j] != 0) col.add(grid[i][j]);
        for (int i = col.length - 1; i > 0; i--) {
          if (col[i] == col[i - 1]) {
            col[i] *= 2;
            col[i - 1] = 0;
          }
        }
        col = col.where((v) => v != 0).toList();
        while (col.length < 4) col.insert(0, 0);
        for (int i = 0; i < 4; i++) grid[i][j] = col[i];
      }
      addRandomTile();
    });
  }

  List<List<int>> copyGrid() {
    return grid.map((row) => List<int>.from(row)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("2048 Game")),
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < 0) moveUp();
          else if (details.primaryVelocity! > 0) moveDown();
        },
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) moveLeft();
          else if (details.primaryVelocity! > 0) moveRight();
        },
        child: Container(
          color: Colors.grey[300],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (i) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (j) {
                  int val = grid[i][j];
                  return Container(
                    margin: EdgeInsets.all(5),
                    width: 70,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: val == 0
                          ? Colors.grey[400]
                          : Colors.orange[100 * (log(val) ~/ log(2)).toInt()],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      val != 0 ? '$val' : '',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  );
                }),
              );
            }),
          ),
        ),
      ),
    );
  }
}