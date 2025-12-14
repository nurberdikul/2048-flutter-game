// lib/game_engine.dart
import 'dart:math';
import 'point.dart';

class GameEngine {
  List<List<int>> _grid;
  int _score;
  final int size;
  
  GameEngine(this.size) 
    : _grid = List.generate(size, (_) => List.filled(size, 0)),
      _score = 0 {
    _addRandomTile();
    _addRandomTile();
  }
  
  List<List<int>> get grid => _grid;
  int get score => _score;
  
  void _addRandomTile() {
    final empty = <Point<int>>[];
    for (int x = 0; x < size; x++) {
      for (int y = 0; y < size; y++) {
        if (_grid[x][y] == 0) empty.add(Point(x, y));
      }
    }
    if (empty.isNotEmpty) {
      final point = (empty..shuffle()).first;
      _grid[point.x][point.y] = Random().nextInt(10) < 9 ? 2 : 4;
    }
  }
  
  void setGrid(List<List<int>> newGrid) {
    _grid = newGrid;
  }
  
  void setScore(int newScore) {
    _score = newScore;
  }
  
  List<List<int>> copyGrid() {
    return _grid.map((row) => List<int>.from(row)).toList();
  }
  
  void addRandomTile() {
    _addRandomTile();
  }
  
  bool canMove() {
    // Проверка пустых клеток
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (_grid[i][j] == 0) return true;
      }
    }
    
    // Проверка возможных слияний
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        int val = _grid[i][j];
        if (j < size - 1 && _grid[i][j + 1] == val) return true;
        if (i < size - 1 && _grid[i + 1][j] == val) return true;
      }
    }
    
    return false;
  }
}