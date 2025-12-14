// how_to_play_page.dart (Окончательное обновление цветов)

import 'package:flutter/material.dart';
import 'mycolor.dart';

class HowToPlayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Color(MyColor.gridBackground); 
    Color cardColor = Color(MyColor.emptyGridBackground); 
    
    Color primaryTextColor = Colors.black; 
    
    // ИСПРАВЛЕНИЕ: Устанавливаем черный цвет для выделенных заголовков карточек
    Color highlightColor = Colors.black; 
    

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Как играть',
          style: TextStyle(
            fontFamily: 'StarJedi', 
            fontSize: 25.0, 
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),
        ),
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // --- Карточка: Цель Игры ---
            _buildInfoCard(
              context,
              cardColor,
              highlightColor,
              primaryTextColor,
              'Цель Игры',
              'Соберите плитку со значением 2048, комбинируя плитки с одинаковыми числами на сетке 4x4. Для победы нужно собрать 2048.',
            ),
            
            const SizedBox(height: 15.0),

            // --- Карточка: Правила и Ходы ---
            _buildRulesCard(
              context,
              cardColor,
              highlightColor,
              primaryTextColor,
              'Правила и Ходы',
              [
                {'title': 'Свайпы', 'description': 'Используйте свайпы (вверх, вниз, влево или вправо), чтобы перемещать все плитки по сетке в выбранном направлении.'},
                {'title': 'Слияние', 'description': 'Когда две плитки с одинаковым числом сталкиваются, они объединяются в одну плитку, удваивая свое значение.'},
                {'title': 'Новая плитка', 'description': 'После каждого хода на пустом месте на сетке появляется новая плитка со значением 2 или 4.'},
              ],
            ),
            
            const SizedBox(height: 15.0),
            
            // --- Карточка: Конец Игры ---
            _buildInfoCard(
              context,
              cardColor,
              highlightColor,
              primaryTextColor,
              'Конец Игры',
              'Игра заканчивается, когда вся сетка заполнена плитками, и нет возможных ходов (т.е. нет соседних плиток с одинаковыми значениями для слияния).',
            ),
          ],
        ),
      ),
    );
  }

  // --- Вспомогательный Виджет: Общая Информационная Карточка ---
  Widget _buildInfoCard(BuildContext context, Color cardColor, Color highlightColor, Color textColor, String title, String content) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'StarJedi', 
                fontSize: 26.0, 
                fontWeight: FontWeight.bold, 
                color: highlightColor, // Теперь черный
              ),
            ),
            const Divider(height: 20, color: Colors.black26),
            Text(
              content,
              style: TextStyle(fontSize: 18.0, color: textColor),
            ),
          ],
        ),
      ),
    );
  }

  // --- Вспомогательный Виджет: Карточка для Правил ---
  Widget _buildRulesCard(BuildContext context, Color cardColor, Color highlightColor, Color textColor, String title, List<Map<String, String>> rules) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'StarJedi', 
                fontSize: 26.0, 
                fontWeight: FontWeight.bold, 
                color: highlightColor, // Теперь черный
              ),
            ),
            const Divider(height: 20, color: Colors.black26),
            ...rules.map((rule) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${rule['title']}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      // Оставляем цвет плиток для подзаголовка, он достаточно темный
                      color: Color(MyColor.fontColorTwoFour), 
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                    child: Text(
                      rule['description']!,
                      style: TextStyle(fontSize: 16.0, color: textColor),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}