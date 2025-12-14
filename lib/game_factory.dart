// lib/game_factory.dart
import 'game_engine.dart';
import 'command/command_manager.dart';

// Enum для направления (перенесен сюда)
enum Direction { left, right, up, down }

abstract class GameFactory {
  GameEngine createGameEngine(int size);
  CommandManager createCommandManager();
}

class StandardGameFactory implements GameFactory {
  @override
  GameEngine createGameEngine(int size) {
    return GameEngine(size);
  }
  
  @override
  CommandManager createCommandManager() {
    return CommandManager()..setMaxHistory(20);
  }
}

class ChallengeGameFactory implements GameFactory {
  @override
  GameEngine createGameEngine(int size) {
    final engine = GameEngine(size);
    // Добавляем дополнительные начальные плитки для сложности
    engine.addRandomTile();
    return engine;
  }
  
  @override
  CommandManager createCommandManager() {
    return CommandManager()..setMaxHistory(5); // Меньше отмен в сложном режиме
  }
}