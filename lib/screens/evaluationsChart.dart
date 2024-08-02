import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class EvaluationsChart extends StatelessWidget {
  const EvaluationsChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Évaluations Chart',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[900],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBarChart(),
                const SizedBox(height: 20),
                _buildPieChart('La présentation du cours'),
                const SizedBox(height: 20),
                _buildPieChart('La pédagogie adoptée'),
                const SizedBox(height: 20),
                _buildPieChart('L\'adaptation des activités d\'apprentissage aux objectifs des cours'),
                const SizedBox(height: 20),
                _buildPieChart('Atteinte des acquis d\'apprentissage'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'La charge de travail en heures associée au cours',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false), // Adjust as needed
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false), // Adjust as needed
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        fromY: 0,
                        toY: 10,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        fromY: 0,
                        toY: 20,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(String title) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 70, // Adjust the value as needed
                    color: Colors.green,
                    title: 'Satisfait',
                    radius: 60,
                    titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  PieChartSectionData(
                    value: 30, // Adjust the value as needed
                    color: Colors.red,
                    title: 'Non Satisfait',
                    radius: 60,
                    titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
                borderData: FlBorderData(show: false),
                centerSpaceRadius: 40, // Adjust if needed
              ),
            ),
          ),
        ],
      ),
    );
  }
}
