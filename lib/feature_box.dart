import 'package:flutter/material.dart';
import 'package:my_forteenth_project/core/models/health_metric.dart';
import 'package:my_forteenth_project/ui/theme/app_colors.dart';
import 'package:my_forteenth_project/ui/widgets/custom_app_bar.dart';

// Import your specific detail screens
import 'package:my_forteenth_project/ui/screens/blood_pressure_screen.dart';
import 'package:my_forteenth_project/ui/screens/cholesterol_screen.dart';
import 'package:my_forteenth_project/ui/screens/blood_sugar_screen.dart';
// REMOVED: import 'package:my_forteenth_project/ui/screens/heart_rate_screen.dart';

class HealthDataScreen extends StatelessWidget {
  const HealthDataScreen({super.key});

  static final List<HealthMetric> _healthMetrics = [
    HealthMetric(
        title: 'Blood Pressure',
        value: '120/80',
        unit: 'mmHg',
        icon: Icons.monitor_heart,
        color: AppColors.primary),
    HealthMetric(
        title: 'Blood Sugar', // Moved up for new arrangement
        value: '90',
        unit: 'mg/dL',
        icon: Icons.bloodtype_outlined,
        color: AppColors.warning),
    HealthMetric(
        title: 'Cholesterol', // Moved down for new arrangement
        value: 'LDL: 100\nHDL: 50',
        unit: 'mg/dL',
        icon: Icons.local_hospital_outlined,
        color: AppColors.info),
    // REMOVED: Heart Rate metric
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Health Data'),
      backgroundColor: AppColors.pageBackground,
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          // crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2,
        ),
        itemCount: _healthMetrics.length,
        itemBuilder: (context, index) {
          final metric = _healthMetrics[index];
          return InkWell(
            onTap: () {
              Widget destinationPage;
              switch (metric.title) {
                case 'Blood Pressure':
                  destinationPage = BloodPressureScreen(metric: metric);
                  break;
                case 'Cholesterol':
                  destinationPage = CholesterolScreen(metric: metric);
                  break;
                case 'Blood Sugar':
                  destinationPage = BloodSugarScreen(metric: metric);
                  break;
              // REMOVED: case 'Heart Rate':
              // REMOVED:   destinationPage = HeartRateScreen(metric: metric);
              // REMOVED:   break;
                default:
                  destinationPage = Scaffold(
                    appBar: AppBar(title: const Text('Error')),
                    body: const Center(child: Text('Unknown metric page')),
                  );
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => destinationPage,
                ),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Card(
              elevation: 2,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
              color: metric.color.withOpacity(0.15),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(metric.icon, size: 56, color: metric.color),
                    const Spacer(),
                    Text(metric.title,
                        style: TextStyle(fontWeight: FontWeight.bold, color: metric.color, fontSize: 16)),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: AppColors.textColor, fontSize: 24, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(text: metric.value),
                          TextSpan(
                            text: ' ${metric.unit}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
