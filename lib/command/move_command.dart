// lib/command/move_command.dart
import 'command_interface.dart';
import 'command_receiver.dart';

enum Direction { left, right, up, down }

class MoveCommand implements GameCommand {
  final CommandReceiver _receiver;
  final Direction _direction;
  List<List<int>>? _previousGrid;
  int? _previousScore;
  bool _wasExecuted = false;
  
  MoveCommand(this._receiver, this._direction);
  
  @override
  void execute() {
    _previousGrid = _receiver.copyGrid();
    _previousScore = _receiver.score;
    
    switch (_direction) {
      case Direction.left:
        _receiver.performMoveLeft();
        break;
      case Direction.right:
        _receiver.performMoveRight();
        break;
      case Direction.up:
        _receiver.performMoveUp();
        break;
      case Direction.down:
        _receiver.performMoveDown();
        break;
    }
    
    _wasExecuted = true;
  }
  
  @override
  void undo() {
    if (_previousGrid != null && _previousScore != null) {
      _receiver.setGrid(_previousGrid!);
      _receiver.setScore(_previousScore!);
    }
  }
  
  @override
  bool get wasExecuted => _wasExecuted;
}