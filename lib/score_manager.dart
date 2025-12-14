// lib/score_manager.dart - БЕЗ SharedPreferences (для демонстрации)
class ScoreManager {
  static final ScoreManager _instance = ScoreManager._internal();
  int _highScore = 0;

  factory ScoreManager() => _instance;
  
  ScoreManager._internal() {
    // Просто загружаем из памяти для демо
    _highScore = 0;
  }

  Future<void> saveHighScore(int score) async {
    if (score > _highScore) {
      _highScore = score;
      // Для демонстрации - просто сохраняем в памяти
      print('Новый рекорд сохранен: $score');
    }
  }

  Future<int> loadHighScore() async {
    // Для демонстрации - возвращаем из памяти
    return _highScore;
  }

  int get highScore => _highScore;

  Future<void> resetHighScore() async {
    _highScore = 0;
    print('Рекорд сброшен');
  }
}