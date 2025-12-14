// lib/main_menu.dart
import 'package:flutter/material.dart';
import 'home.dart';
import 'game_factory.dart';
import 'settings_page.dart';
import 'how_to_play_page.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF8EF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title with better font
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [
                        Color(0xFFF67C5F),
                        Color(0xFFF65E3B),
                        Color(0xFFEDC22E),
                      ],
                      stops: [0.0, 0.5, 1.0],
                    ).createShader(bounds);
                  },
                  child: Text(
                    '2048',
                    style: TextStyle(
                      fontSize: 82,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Arial',
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Соединяй плитки и получи 2048!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF776E65),
                    fontFamily: 'Arial',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                
                // Game modes
                _buildMenuCard(
                  title: 'СТАНДАРТНАЯ ИГРА',
                  subtitle: 'Классика 4×4',
                  color: Color(0xFF8F7A66),
                  icon: Icons.play_circle_filled,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomePage(
                          gameFactory: StandardGameFactory(),
                          gridSize: 4,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                
                _buildMenuCard(
                  title: 'СЛОЖНЫЙ РЕЖИМ',
                  subtitle: 'Сложнее, но интереснее',
                  color: Color(0xFFF67C5F),
                  icon: Icons.whatshot,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomePage(
                          gameFactory: ChallengeGameFactory(),
                          gridSize: 4,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                
                _buildMenuCard(
                  title: 'ВЫБОР РАЗМЕРА',
                  subtitle: 'От 3×3 до 6×6',
                  color: Color(0xFFF2B179),
                  icon: Icons.grid_view,
                  onTap: () {
                    _showGridSizeDialog(context);
                  },
                ),
                SizedBox(height: 40),
                
                // Bottom buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildIconButton(
                      icon: Icons.settings,
                      label: 'Настройки',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SettingsPage()),
                        );
                      },
                    ),
                    _buildIconButton(
                      icon: Icons.help_outline,
                      label: 'Помощь',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => HowToPlayPage()),
                        );
                      },
                    ),
                    _buildIconButton(
                      icon: Icons.leaderboard,
                      label: 'Рекорды',
                      onTap: () {
                        // Можно добавить экран рекордов
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildMenuCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(100),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 36,
              color: Colors.white,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Arial',
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(200, 255, 255, 255),
                      fontFamily: 'Arial',
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF8F7A66).withAlpha(30),
          ),
          child: IconButton(
            onPressed: onTap,
            icon: Icon(icon, size: 28),
            color: Color(0xFF8F7A66),
            style: IconButton.styleFrom(
              padding: EdgeInsets.all(16),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF776E65),
            fontFamily: 'Arial',
          ),
        ),
      ],
    );
  }
  
  void _showGridSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Выберите размер сетки',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF776E65),
                  fontFamily: 'Arial',
                ),
              ),
              SizedBox(height: 20),
              _buildGridSizeOption(context, size: 3, name: '3×3 (Легко)', color: Color(0xFF8F7A66)),
              _buildGridSizeOption(context, size: 4, name: '4×4 (Классика)', color: Color(0xFFF67C5F)),
              _buildGridSizeOption(context, size: 5, name: '5×5 (Сложно)', color: Color(0xFFF2B179)),
              _buildGridSizeOption(context, size: 6, name: '6×6 (Эксперт)', color: Color(0xFFEDC850)),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildGridSizeOption(BuildContext context, {required int size, required String name, required Color color}) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(
          fontFamily: 'Arial',
          color: Color(0xFF776E65),
        ),
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            '$size',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Color(0xFF776E65)),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(
              gameFactory: StandardGameFactory(),
              gridSize: size,
            ),
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}