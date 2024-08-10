import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alert_provider.dart';
import 'package:fl_chart/fl_chart.dart';

class HeatmapPage extends StatelessWidget {
  final List<FlSpot> temperatureData = [
    FlSpot(1, 20), // Time 1, Temperature 20°C
    FlSpot(2, 22), // Time 2, Temperature 22°C
    FlSpot(3, 21), // Time 3, Temperature 21°C
    FlSpot(4, 25), // Time 4, Temperature 25°C
    FlSpot(5, 24), // Time 5, Temperature 24°C
  ];

  final List<FlSpot> humidityData = [
    FlSpot(1, 60), // Time 1, Humidity 60%
    FlSpot(2, 65), // Time 2, Humidity 65%
    FlSpot(3, 63), // Time 3, Humidity 63%
    FlSpot(4, 70), // Time 4, Humidity 70%
    FlSpot(5, 68), // Time 5, Humidity 68%
  ];

  final List<FlSpot> windspeedData = [
    FlSpot(1, 5), // Time 1, Windspeed 5 km/h
    FlSpot(2, 7), // Time 2, Windspeed 7 km/h
    FlSpot(3, 6), // Time 3, Windspeed 6 km/h
    FlSpot(4, 8), // Time 4, Windspeed 8 km/h
    FlSpot(5, 9), // Time 5, Windspeed 9 km/h
  ];

  final List<FlSpot> precipitationData = [
    FlSpot(1, 2), // Time 1, Precipitation 2 mm
    FlSpot(2, 3), // Time 2, Precipitation 3 mm
    FlSpot(3, 1), // Time 3, Precipitation 1 mm
    FlSpot(4, 4), // Time 4, Precipitation 4 mm
    FlSpot(5, 2), // Time 5, Precipitation 2 mm
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather and Crowd Density Over Time'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_active),
            onPressed: () {
              Provider.of<AlertProvider>(context, listen: false)
                  .addAlert("High temperature detected at time T3!");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: const Color(0xffe7e8ec),
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: const Color(0xffe7e8ec),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              'T${value.toInt()}',
                              style: TextStyle(fontSize: 14),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              value.toInt().toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xff37434d),
                      width: 1,
                    ),
                  ),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots: temperatureData,
                      isCurved: true,
                      color: Colors.blue,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                      barWidth: 2,
                    ),
                    LineChartBarData(
                      spots: humidityData,
                      isCurved: true,
                      color: Colors.green,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                      barWidth: 2,
                    ),
                    LineChartBarData(
                      spots: windspeedData,
                      isCurved: true,
                      color: Colors.orange,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                      barWidth: 2,
                    ),
                    LineChartBarData(
                      spots: precipitationData,
                      isCurved: true,
                      color: Colors.purple,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                      barWidth: 2,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Legend(color: Colors.blue, label: 'Temperature'),
                _Legend(color: Colors.green, label: 'Humidity'),
                _Legend(color: Colors.orange, label: 'Windspeed'),
                _Legend(color: Colors.purple, label: 'Precipitation'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<AlertProvider>(context, listen: false)
              .addAlert("High crowd density detected at time T4!");
        },
        child: Icon(Icons.add_alert),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;

  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
