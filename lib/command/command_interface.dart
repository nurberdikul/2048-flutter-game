// lib/command/command_interface.dart
abstract class GameCommand {
  void execute();
  void undo();
  bool get wasExecuted;
}