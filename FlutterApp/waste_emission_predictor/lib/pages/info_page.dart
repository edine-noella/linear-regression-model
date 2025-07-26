import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About This App'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Waste Emission Predictor',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'This app helps predict methane emissions from waste management practices. '
                  'Methane is a potent greenhouse gas that contributes significantly to climate change.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'How to Use:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '1. Enter the percentage of organic waste in your waste stream\n'
                  '2. Enter the population of your area\n'
                  '3. Enter the GDP per capita in USD\n'
                  '4. Enter the percentage of waste going to landfill\n'
                  '5. Enter the average waste generated per person per day\n'
                  '6. Click "PREDICT EMISSIONS" to see the estimated methane emissions',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}