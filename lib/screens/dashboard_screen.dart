import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // DUMMY DATA - Replace with your live data from the backend/sensors
    final double organicWaste = 4.2; // in kg
    final double recyclableWaste = 2.8; // in kg
    final double hazardousWaste = 0.5; // in kg
    final double binFillLevel = 0.75; // 75% full
    final double totalWaste = organicWaste + recyclableWaste + hazardousWaste;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          // App Bar with Greeting
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16, right: 20),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back!',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Waste Overview',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF1E293B),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: IconButton(
                    icon: const Icon(Iconsax.notification, color: Color(0xFF1E293B)),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          
          // Main Content
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Stats Overview Cards
                _buildStatsOverview(totalWaste, context),
                const SizedBox(height: 24),
                
                // Waste Categories Grid
                Text(
                  'Waste Categories',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildWasteCategoriesGrid(
                  organicWaste,
                  recyclableWaste,
                  hazardousWaste,
                  context,
                ),
                const SizedBox(height: 24),

                // Bin Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bin Status',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF3B82F6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildBinLevelIndicator(binFillLevel, context),
                const SizedBox(height: 32),

                // Weekly Summary
                Text(
                  'Weekly Summary',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 200,
                    child: _buildBarChart(),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  // Stats Overview Card
  Widget _buildStatsOverview(double totalWaste, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.trash, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                'Total Waste Collected',
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '${totalWaste.toStringAsFixed(1)} kg',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This month',
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Waste Categories Grid
  Widget _buildWasteCategoriesGrid(
    double organicWaste,
    double recyclableWaste,
    double hazardousWaste,
    BuildContext context,
  ) {
    final List<Map<String, dynamic>> wasteData = [
      {
        'title': 'Organic',
        'amount': organicWaste,
        'icon': Icons.eco_rounded,
        'color': const Color(0xFF10B981),
        'bgColor': const Color(0xFFD1FAE5),
      },
      {
        'title': 'Recyclable',
        'amount': recyclableWaste,
        'icon': Icons.recycling_rounded,
        'color': const Color(0xFF3B82F6),
        'bgColor': const Color(0xFFDBEAFE),
      },
      {
        'title': 'Hazardous',
        'amount': hazardousWaste,
        'icon': Icons.warning_rounded,
        'color': const Color(0xFFF59E0B),
        'bgColor': const Color(0xFFFEF3C7),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: wasteData.length,
      itemBuilder: (context, index) {
        final data = wasteData[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: data['bgColor'],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  data['icon'],
                  color: data['color'],
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${data['amount']} kg',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data['title'],
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '${(level * 100).toInt()}% Full',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                height: 12,
                width: MediaQuery.of(context).size.width * 0.8 * level,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      fillColor,
                      fillColor.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0%',
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              Text(
                '100%',
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to build the bar chart
  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 10, // Max kg of waste per day
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
              reservedSize: 38,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getLeftTitles,
              reservedSize: 28,
              interval: 2,
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          // Dummy data for the week
          makeGroupData(0, 5, Colors.green),
          makeGroupData(1, 6.5, Colors.green),
          makeGroupData(2, 5, Colors.green),
          makeGroupData(3, 7.5, Colors.green),
          makeGroupData(4, 9, Colors.green),
          makeGroupData(5, 4, Colors.green),
          makeGroupData(6, 6, Colors.green),
        ],
      ),
    );
  }
}

// --- Chart Helper Functions ---

// ** THIS FUNCTION IS CORRECTED **
Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xFF64748B),
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('MON', style: style);
      break;
    case 1:
      text = const Text('TUE', style: style);
      break;
    case 2:
      text = const Text('WED', style: style);
      break;
    case 3:
      text = const Text('THU', style: style);
      break;
    case 4:
      text = const Text('FRI', style: style);
      break;
    case 5:
      text = const Text('SAT', style: style);
      break;
    case 6:
      text = const Text('SUN', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4,
    child: text,
  );
}

// ** THIS FUNCTION IS CORRECTED **
Widget getLeftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  if (value == 0) {
    text = '0';
  } else if (value == 2) {
    text = '2kg';
  } else if (value == 4) {
    text = '4kg';
  } else if (value == 6) {
    text = '6kg';
  } else if (value == 8) {
    text = '8kg';
  } else if (value == 10) {
    text = '10kg';
  }
  else {
    return Container();
  }
  return Text(text, style: style, textAlign: TextAlign.left);
}

BarChartGroupData makeGroupData(int x, double y, Color color) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        color: color,
        width: 8,
        borderRadius: BorderRadius.circular(4),
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          toY: 10,
          color: const Color(0xFFF1F5F9),
        ),
      ),
    ],
  );
}
