import 'package:flutter/material.dart';

class ReservationHowItWorksRow extends StatelessWidget {
  const ReservationHowItWorksRow({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamically calculate boxWidth and ensure it's a double
    final double boxWidth = screenWidth < 600 ? screenWidth * 0.28 : 180.0;

    // Calculate icon size and label font size dynamically
    double iconSize = screenWidth < 600 ? 14.0 : 14.0;
    double labelFontSize = screenWidth < 600 ? 12.0 : 12.0;

    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing:
                screenWidth < 600 ? 4.0 : 8.0, // Adjust spacing dynamically
            runSpacing: 16, // Vertical spacing for wrapped rows
            alignment: WrapAlignment.center, // Center align all items
            children: [
              _buildIconBox(
                context: context,
                icon: Icons.directions_car,
                label: 'Choose Car or Tour Guide',
                boxWidth: boxWidth, // Pass dynamic width
                iconSize: iconSize, // Pass dynamic icon size
                labelFontSize: labelFontSize, // Pass dynamic label font size
                delay: 300,
              ),
              _buildIconBox(
                context: context,
                icon: Icons.date_range,
                label: 'Place reservation',
                boxWidth: boxWidth, // Pass dynamic width
                iconSize: iconSize, // Pass dynamic icon size
                labelFontSize: labelFontSize, // Pass dynamic label font size
                delay: 0,
              ),
              _buildIconBox(
                context: context,
                icon: Icons.check_circle,
                label: 'Confirm Booking',
                boxWidth: boxWidth, // Pass dynamic width
                iconSize: iconSize, // Pass dynamic icon size
                labelFontSize: labelFontSize, // Pass dynamic label font size
                delay: 600,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconBox({
    required BuildContext context,
    required IconData icon,
    required String label,
    required double boxWidth, // Ensure it's a double
    required double iconSize, // Dynamic icon size
    required double labelFontSize, // Dynamic label font size
    required int delay,
  }) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 1000),
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: Container(
          width: boxWidth, // Use dynamic width
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: iconSize,
                  color: Colors.blueAccent), // Adjust icon size dynamically
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: labelFontSize, // Adjust label font size dynamically
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
