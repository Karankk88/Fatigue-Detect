// lib/screens/stats_screen.dart
import 'package:fatigue_detect/screens/camera_screen.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Add fl_chart to pubspec.yaml if not added

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraScreen()),
    );
  },

),
        title: Text('Stats', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fatigue Motion Analysis Card
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fatigue Motion Analysis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 250,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true, drawVerticalLine: true),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 0:
                                    return Text('00:00');
                                  case 1:
                                    return Text('01:00');
                                  case 2:
                                    return Text('02:00');
                                  case 3:
                                    return Text('03:00');
                                  case 4:
                                    return Text('04:00');
                                  case 5:
                                    return Text('05:00');
                                  case 6:
                                    return Text('06:00');
                                }
                                return Text('');
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: true),
                        minX: 0,
                        maxX: 6,
                        minY: 0,
                        maxY: 1,
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 0.2),
                              FlSpot(1, 0.3),
                              FlSpot(2, 0.5),
                              FlSpot(3, 0.4),
                              FlSpot(4, 0.6),
                              FlSpot(5, 0.8),
                              FlSpot(6, 0.7),
                            ],
                            isCurved: true,
                            color: Colors.purple,
                            barWidth: 3,
                            dotData: FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Average Fatigue Level and Alert Response Rate Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Average Fatigue Level', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('0.45', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Last 24 hours', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alert Response Rate', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('92%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Response to fatigue alerts', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}