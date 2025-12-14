// lib/home.dart - СУПЕР КОМПАКТНЫЙ ВАРИАНТ
import 'package:flutter/material.dart';
import 'dart:math';
import 'game_engine.dart';
import 'command/command_manager.dart';
import 'command/command_interface.dart';
import 'tile_component.dart';
import 'game_factory.dart';

// Простая реализация GameCommand
class _MoveCommand implements GameCommand {
  final List<List<int>> previousGrid;
  final int previousScore;
  final VoidCallback onUndo;
  bool _executed = true;
  
  _MoveCommand({
    required this.previousGrid,
    required this.previousScore,
    required this.onUndo,
  });
  
  @override
  void execute() {
    // Команда уже выполнена при создании
  }
  
  @override
  void undo() {
    onUndo();
    _executed = false;
  }
  
  @override
  bool get wasExecuted => _executed;
}

class HomePage extends StatefulWidget {
  final GameFactory gameFactory;
  final int gridSize;
  
  const HomePage({
    Key? key,
    required this.gameFactory,
    this.gridSize = 4,
  }) : super(key: key);
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GameEngine _gameEngine;
  late CommandManager _commandManager;
  late TileFactory _tileFactory;
  late bool _isGameOver;
  late bool _isGameWon;
  int _moveCount = 0;
  int _bestScore = 0;
  
  @override
  void initState() {
    super.initState();
    _gameEngine = GameEngine(widget.gridSize);
    _commandManager = CommandManager();
    _tileFactory = DefaultTileFactory();
    _isGameOver = false;
    _isGameWon = false;
    _loadBestScore();
  }
  
  Future<void> _loadBestScore() async {
    _bestScore = 0;
  }
  
  void _saveBestScore() {
    if (_gameEngine.score > _bestScore) {
      _bestScore = _gameEngine.score;
    }
  }
  
  // Movement methods
  void _moveTilesLeft() {
    for (int i = 0; i < _gameEngine.size; i++) {
      List<int> newRow = _gameEngine.grid[i].where((v) => v != 0).toList();
      for (int j = 0; j < newRow.length - 1; j++) {
        if (newRow[j] == newRow[j + 1]) {
          newRow[j] *= 2;
          _gameEngine.setScore(_gameEngine.score + newRow[j]);
          newRow[j + 1] = 0;
          if (newRow[j] == 2048) {
            _isGameWon = true;
          }
        }
      }
      newRow = newRow.where((v) => v != 0).toList();
      while (newRow.length < _gameEngine.size) newRow.add(0);
      final newGrid = List<List<int>>.from(_gameEngine.grid);
      newGrid[i] = newRow;
      _gameEngine.setGrid(newGrid);
    }
  }
  
  void _moveTilesRight() {
    for (int i = 0; i < _gameEngine.size; i++) {
      List<int> newRow = _gameEngine.grid[i].where((v) => v != 0).toList();
      for (int j = newRow.length - 1; j > 0; j--) {
        if (newRow[j] == newRow[j - 1]) {
          newRow[j] *= 2;
          _gameEngine.setScore(_gameEngine.score + newRow[j]);
          newRow[j - 1] = 0;
          if (newRow[j] == 2048) {
            _isGameWon = true;
          }
        }
      }
      newRow = newRow.where((v) => v != 0).toList();
      while (newRow.length < _gameEngine.size) newRow.insert(0, 0);
      final newGrid = List<List<int>>.from(_gameEngine.grid);
      newGrid[i] = newRow;
      _gameEngine.setGrid(newGrid);
    }
  }
  
  void _moveTilesUp() {
    final size = _gameEngine.size;
    for (int j = 0; j < size; j++) {
      List<int> col = [];
      for (int i = 0; i < size; i++) {
        if (_gameEngine.grid[i][j] != 0) col.add(_gameEngine.grid[i][j]);
      }
      for (int i = 0; i < col.length - 1; i++) {
        if (col[i] == col[i + 1]) {
          col[i] *= 2;
          _gameEngine.setScore(_gameEngine.score + col[i]);
          col[i + 1] = 0;
          if (col[i] == 2048) {
            _isGameWon = true;
          }
        }
      }
      col = col.where((v) => v != 0).toList();
      while (col.length < size) col.add(0);
      final newGrid = List<List<int>>.from(_gameEngine.grid);
      for (int i = 0; i < size; i++) {
        newGrid[i][j] = col[i];
      }
      _gameEngine.setGrid(newGrid);
    }
  }
  
  void _moveTilesDown() {
    final size = _gameEngine.size;
    for (int j = 0; j < size; j++) {
      List<int> col = [];
      for (int i = 0; i < size; i++) {
        if (_gameEngine.grid[i][j] != 0) col.add(_gameEngine.grid[i][j]);
      }
      for (int i = col.length - 1; i > 0; i--) {
        if (col[i] == col[i - 1]) {
          col[i] *= 2;
          _gameEngine.setScore(_gameEngine.score + col[i]);
          col[i - 1] = 0;
          if (col[i] == 2048) {
            _isGameWon = true;
          }
        }
      }
      col = col.where((v) => v != 0).toList();
      while (col.length < size) col.insert(0, 0);
      final newGrid = List<List<int>>.from(_gameEngine.grid);
      for (int i = 0; i < size; i++) {
        newGrid[i][j] = col[i];
      }
      _gameEngine.setGrid(newGrid);
    }
  }
  
  // Game control methods
  void _moveLeft() {
    _move(Direction.left);
  }
  
  void _moveRight() {
    _move(Direction.right);
  }
  
  void _moveUp() {
    _move(Direction.up);
  }
  
  void _moveDown() {
    _move(Direction.down);
  }
  
  void _move(Direction direction) {
    if (_isGameOver) return;
    
    final previousGrid = _gameEngine.copyGrid();
    final previousScore = _gameEngine.score;
    
    switch (direction) {
      case Direction.left:
        _moveTilesLeft();
        break;
      case Direction.right:
        _moveTilesRight();
        break;
      case Direction.up:
        _moveTilesUp();
        break;
      case Direction.down:
        _moveTilesDown();
        break;
    }
    
    bool moved = false;
    for (int i = 0; i < _gameEngine.size && !moved; i++) {
      for (int j = 0; j < _gameEngine.size && !moved; j++) {
        if (_gameEngine.grid[i][j] != previousGrid[i][j]) {
          moved = true;
        }
      }
    }
    
    if (moved) {
      _moveCount++;
      _gameEngine.addRandomTile();
      _checkGameState();
      _saveBestScore();
      
      final command = _MoveCommand(
        previousGrid: previousGrid,
        previousScore: previousScore,
        onUndo: () {
          _gameEngine.setGrid(previousGrid);
          _gameEngine.setScore(previousScore);
          setState(() {});
        },
      );
      
      _commandManager.executeCommand(command);
      setState(() {});
    }
  }
  
  void _undo() {
    if (_commandManager.canUndo) {
      _commandManager.undoLastCommand();
      setState(() {});
    }
  }
  
  void _checkGameState() {
    if (!_gameEngine.canMove()) {
      _isGameOver = true;
    }
  }
  
  void _restart() {
    setState(() {
      _gameEngine = GameEngine(widget.gridSize);
      _commandManager = CommandManager();
      _isGameOver = false;
      _isGameWon = false;
      _moveCount = 0;
    });
  }
  
  void _changeTileFactory(TileFactory factory) {
    setState(() {
      _tileFactory = factory;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Компактный расчет размера сетки
    double calculateGridSize() {
      if (screenHeight < 600) {
        // Для очень маленьких экранов
        return min(screenWidth * 0.9, 300.0);
      }
      final baseSize = min(screenWidth, screenHeight * 0.55); // Уменьшил до 55%
      if (_gameEngine.size <= 4) {
        return min(baseSize - 20, 320.0); // Уменьшил до 320
      } else if (_gameEngine.size == 5) {
        return min(baseSize - 25, 280.0);
      } else {
        return min(baseSize - 30, 240.0);
      }
    }
    
    final gridSize = calculateGridSize();
    final tileSize = (gridSize - (_gameEngine.size + 1) * 4) / _gameEngine.size;
    
    final showControlButtons = _gameEngine.size <= 5;
    
    // Компактные карточки счета
    List<Widget> scoreCards = [
      _buildScoreCard('СЧЕТ', _gameEngine.score, Color(0xFF8F7A66)),
      _buildScoreCard('РЕКОРД', _bestScore, Color(0xFFF67C5F)),
      if (showControlButtons) 
        _buildScoreCard('ХОДЫ', _moveCount, Color(0xFFF2B179)),
    ];
    
    return Scaffold(
      backgroundColor: Color(0xFFFAF8EF),
      appBar: AppBar(
        backgroundColor: Color(0xFF8F7A66),
        foregroundColor: Colors.white,
        title: Text(
          '2048',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20, // Уменьшил шрифт
            fontFamily: 'Arial',
          ),
        ),
        centerTitle: true,
        elevation: 2, // Уменьшил тень
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 22),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Назад',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Score panel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: scoreCards,
              ),
            ),
            
            // Game status (компактный)
            if (_isGameWon)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF60D394),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.celebration, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'ПОБЕДА!',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Arial',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            if (_isGameOver)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFEE6055),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sentiment_dissatisfied, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'ИГРА ОКОНЧЕНА!',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Arial',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            SizedBox(height: 2),
            
            // Game grid
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! < 0) _moveLeft();
                  else if (details.primaryVelocity! > 0) _moveRight();
                },
                onVerticalDragEnd: (details) {
                  if (details.primaryVelocity! < 0) _moveUp();
                  else if (details.primaryVelocity! > 0) _moveDown();
                },
                child: Center(
                  child: Container(
                    width: gridSize,
                    height: gridSize,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color(0xFFBBADA0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _gameEngine.size,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                      ),
                      itemCount: _gameEngine.size * _gameEngine.size,
                      itemBuilder: (context, index) {
                        final x = index % _gameEngine.size;
                        final y = index ~/ _gameEngine.size;
                        final value = _gameEngine.grid[y][x];
                        
                        return _tileFactory.createTile(value).build(tileSize);
                      },
                    ),
                  ),
                ),
              ),
            ),
            
            // УПРОЩЕННЫЕ КНОПКИ УПРАВЛЕНИЯ
            if (showControlButtons) ...[
              SizedBox(height: 8),
              
              // Только 3 основные кнопки в ряд
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Кнопка "Отмена" - Command Pattern
                    _buildMiniButton(
                      icon: Icons.undo,
                      label: 'Отмена',
                      onPressed: _commandManager.canUndo ? _undo : null,
                      color: Color(0xFF8F7A66),
                    ),
                    
                    // Кнопка "Новая игра"
                    _buildMiniButton(
                      icon: Icons.refresh,
                      label: 'Новая',
                      onPressed: _restart,
                      color: Color(0xFFF67C5F),
                    ),
                    
                    // Кнопка "Тема" - Decorator Pattern
                    _buildMiniButton(
                      icon: Icons.color_lens,
                      label: 'Тема',
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => _buildCompactThemeSelector(),
                        );
                      },
                      color: Color(0xFF60D394),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 10),
              
              // Компактные стрелки направления
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    // Кнопка ВВЕРХ
                    _buildMiniDirectionButton(
                      icon: Icons.keyboard_arrow_up,
                      onPressed: _moveUp,
                    ),
                    
                    SizedBox(height: 4),
                    
                    // Ряд: ЛЕВО и ПРАВО
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildMiniDirectionButton(
                          icon: Icons.keyboard_arrow_left,
                          onPressed: _moveLeft,
                        ),
                        
                        SizedBox(width: 40),
                        
                        _buildMiniDirectionButton(
                          icon: Icons.keyboard_arrow_right,
                          onPressed: _moveRight,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 4),
                    
                    // Кнопка ВНИЗ
                    _buildMiniDirectionButton(
                      icon: Icons.keyboard_arrow_down,
                      onPressed: _moveDown,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 8),
              
              // Информационная подпись
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Свайпы или кнопки',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF776E65),
                    fontFamily: 'Arial',
                  ),
                ),
              ),
              
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom > 0 ? 
                  MediaQuery.of(context).viewInsets.bottom : 4),
            ] else ...[
              // Для больших сеток только кнопка темы
              SizedBox(height: 8),
              _buildMiniButton(
                icon: Icons.color_lens,
                label: 'Сменить тему',
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => _buildCompactThemeSelector(),
                  );
                },
                color: Color(0xFF60D394),
              ),
              SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildScoreCard(String title, int value, Color color) {
    return Container(
      constraints: BoxConstraints(maxWidth: 60),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF776E65),
              fontWeight: FontWeight.w600,
              fontFamily: 'Arial',
            ),
          ),
          SizedBox(height: 2),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              '$value',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'Arial',
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // СУПЕР КОМПАКТНЫЕ КНОПКИ
  Widget _buildMiniButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 40, // ОЧЕНЬ МАЛЕНЬКИЕ
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, size: 18, color: Colors.white),
            padding: EdgeInsets.zero,
          ),
        ),
        SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: Color(0xFF776E65),
            fontFamily: 'Arial',
          ),
        ),
      ],
    );
  }
  
  // СУПЕР КОМПАКТНЫЕ СТРЕЛКИ
  Widget _buildMiniDirectionButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 45, // ОЧЕНЬ МАЛЕНЬКИЕ
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFF2B179),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFF2B179).withOpacity(0.3),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 24, color: Colors.white),
        padding: EdgeInsets.zero,
      ),
    );
  }
  
  // КОМПАКТНЫЙ ВЫБОР ТЕМЫ
  Widget _buildCompactThemeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Тема',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF776E65),
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildThemeOption('Стандарт', DefaultTileFactory(), Color(0xFFF2B179)),
              _buildThemeOption('Мин.', MinimalTileFactory(), Colors.grey[300]!),
              _buildThemeOption('Радуга', RainbowTileFactory(), Colors.blue),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
  
  Widget _buildThemeOption(String name, TileFactory factory, Color color) {
    final isSelected = _tileFactory.runtimeType == factory.runtimeType;
    
    return GestureDetector(
      onTap: () {
        _changeTileFactory(factory);
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.3) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6),
            Text(
              name,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF776E65),
              ),
            ),
          ],
        ),
      ),
    );
  }
}