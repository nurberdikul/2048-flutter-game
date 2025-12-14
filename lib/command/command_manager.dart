// lib/command/command_manager.dart
import 'command_interface.dart';

class CommandManager {
  final List<GameCommand> _history = [];
  int _maxHistory = 20;
  
  void executeCommand(GameCommand command) {
    command.execute();
    if (command.wasExecuted) {
      _history.add(command);
      if (_history.length > _maxHistory) {
        _history.removeAt(0);
      }
    }
  }
  
  void undoLastCommand() {
    if (_history.isNotEmpty) {
      final lastCommand = _history.removeLast();
      lastCommand.undo();
    }
  }
  
  bool get canUndo => _history.isNotEmpty;
  int get historyLength => _history.length;
  
  void clearHistory() {
    _history.clear();
  }
  
  void setMaxHistory(int max) {
    _maxHistory = max;
  }
}