import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/api_serice.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _organicWasteController = TextEditingController();
  final TextEditingController _populationController = TextEditingController();
  final TextEditingController _gdpController = TextEditingController();
  final TextEditingController _landfillController = TextEditingController();
  final TextEditingController _wastePerCapitaController = TextEditingController();

  String _predictionResult = '';
  bool _isLoading = false;

  Future<void> _predict() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _predictionResult = '';
      });

      try {
        final result = await ApiService.predictEmission(
          organicWaste: double.parse(_organicWasteController.text),
          population: int.parse(_populationController.text),
          gdpPerCapita: double.parse(_gdpController.text),
          landfill: double.parse(_landfillController.text),
          wastePerCapita: double.parse(_wastePerCapitaController.text),
        );

        setState(() {
          _predictionResult = 'Predicted Emissions: '
              '${result['prediction']?.toStringAsFixed(2) ?? 'N/A'} '
              '${result['units'] ?? ''}';
        });
      } catch (e) {
        setState(() {
          _predictionResult = 'Error: ${e.toString()}';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _organicWasteController.dispose();
    _populationController.dispose();
    _gdpController.dispose();
    _landfillController.dispose();
    _wastePerCapitaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Emission Prediction'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Organic Waste Input
              TextFormField(
                controller: _organicWasteController,
                decoration: const InputDecoration(
                  labelText: 'Organic Waste (%)',
                  hintText: 'Enter percentage (0-100)',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a value';
                  final val = double.tryParse(value);
                  if (val == null || val < 0 || val > 100) return 'Enter value between 0-100';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Population Input
              TextFormField(
                controller: _populationController,
                decoration: const InputDecoration(
                  labelText: 'Population',
                  hintText: 'Enter population (min 1000)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a value';
                  final val = int.tryParse(value);
                  if (val == null || val < 1000) return 'Enter value ≥1000';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // GDP Input
              TextFormField(
                controller: _gdpController,
                decoration: const InputDecoration(
                  labelText: 'GDP per Capita (USD)',
                  hintText: 'Enter GDP (min 500)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a value';
                  final val = double.tryParse(value);
                  if (val == null || val < 500) return 'Enter value ≥500';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Landfill Input
              TextFormField(
                controller: _landfillController,
                decoration: const InputDecoration(
                  labelText: 'Landfill Percentage (%)',
                  hintText: 'Enter percentage (0-100)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a value';
                  final val = double.tryParse(value);
                  if (val == null || val < 0 || val > 100) return 'Enter value between 0-100';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Waste per Capita Input
              TextFormField(
                controller: _wastePerCapitaController,
                decoration: const InputDecoration(
                  labelText: 'Waste per Capita (kg/day)',
                  hintText: 'Enter value (0.1-5)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a value';
                  final val = double.tryParse(value);
                  if (val == null || val < 0.1 || val > 5) return 'Enter value between 0.1-5';
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Predict Button
              ElevatedButton(
                onPressed: _isLoading ? null : _predict,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('PREDICT EMISSIONS'),
              ),
              const SizedBox(height: 24),

              // Prediction Result
              if (_predictionResult.isNotEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _predictionResult,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}