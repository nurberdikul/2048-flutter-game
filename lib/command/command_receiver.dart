// lib/command/command_receiver.dart
/// Интерфейс-получатель команд
abstract class CommandReceiver {
  List<List<int>> get grid;
  int get score;
  bool get isGameOver;
  bool get isGameWon;
  
  void setGrid(List<List<int>> newGrid);
  void setScore(int newScore);
  void setGameOver(bool gameOver);
  void setGameWon(bool gameWon);
  
  List<List<int>> copyGrid();
  void addRandomTile();
  bool canMove();
  
  // Методы движения
  void performMoveLeft();
  void performMoveRight();
  void performMoveUp();
  void performMoveDown();
}