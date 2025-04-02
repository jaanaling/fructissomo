import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fructissimo/src/feature/main/bloc/app_bloc.dart';
import 'package:fructissimo/src/feature/main/model/tree.dart';
import 'package:fructissimo/ui_kit/app_app_bar.dart';
import 'package:fructissimo/ui_kit/app_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticScreen extends StatefulWidget {
  final String id;
  const StatisticScreen({super.key, required this.id});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  int selectedChartIndex = 0;

  final List<String> chartTitles = [
    "Watering",
    "Fertilization",
    "Protection",
    "Pests",
    "Harvest",
    "Temperature",
  ];

  // Colors for charts
  final List<Color> chartColors = [
    Colors.blue.shade400,
    Colors.green.shade400,
    Colors.orange.shade400,
    Colors.red.shade400,
    Colors.purple.shade400,
    Colors.teal.shade400,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Placeholder();
        }
        final tree =
            state.trees.firstWhere((element) => element.id == widget.id);

        return SafeArea(
          child: Column(
            children: [
              const AppAppBar(
                title: "Statistic",
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(chartTitles.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: AppButton(
                          style: selectedChartIndex == index
                              ? ButtonColors.green
                              : ButtonColors.orange,
                          text: chartTitles[index],
                          onPressed: () =>
                              setState(() => selectedChartIndex = index),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildChart(tree, selectedChartIndex),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChart(TreeProfile tree, int index) {
    final theme = Theme.of(context);
    final textStyle = TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 24,
      fontFamily: 'Font',
      fontWeight: FontWeight.w500,
    );
    final color = chartColors[index];

    switch (index) {
      case 0: // Watering - Column chart
        return tree.wateringRecords.isEmpty
            ? Center(child: Text("No data available for this chart"))
            : SfCartesianChart(
                palette: [color],
                title: ChartTitle(
                  text: chartTitles[index],
                  textStyle: textStyle,
                ),
                primaryXAxis: CategoryAxis(
                  labelStyle: textStyle.copyWith(fontSize: 12),
                  title: AxisTitle(text: 'Date', textStyle: textStyle),
                ),
                primaryYAxis: NumericAxis(
                  labelStyle: textStyle,
                  title: AxisTitle(text: 'Water Amount', textStyle: textStyle),
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries>[
                  ColumnSeries<WateringRecord, String>(
                    dataSource: tree.wateringRecords,
                    xValueMapper: (WateringRecord record, _) =>
                          record.date.toString().substring(0, 16),
                    yValueMapper: (WateringRecord record, _) => record.amount,
                      dataLabelSettings:  DataLabelSettings(isVisible: true, textStyle: textStyle),
                  ),
                ],
              );
      case 1: // Fertilization - Pie chart
        return tree.fertilizationRecords.isEmpty
            ? Center(child: Text("No data available for this chart"))
            : _buildPieChart<FertilizationRecord>(
                tree.fertilizationRecords,
                (FertilizationRecord record, _) => record.amount,
                (FertilizationRecord record, _) => record.fertilizerName,
                color,
                "Fertilization Amount",
                theme,
              );
      case 2: // Protection - Pie chart
        return tree.protectionRecords.isEmpty
            ? Center(child: Text("No data available for this chart"))
            : _buildPieChart<ProtectionRecord>(
                tree.protectionRecords,
                (ProtectionRecord record, _) => 1.0,
                (ProtectionRecord record, _) => record.protectionName,
                color,
                "Protection Events",
                theme,
              );
      case 3: // Pests - Pie chart
        return tree.pestRecords.isEmpty
            ? Center(child: Text("No data available for this chart"))
            : _buildPieChart<PestRecord>(
                tree.pestRecords,
                (PestRecord record, _) => 1.0,
                (PestRecord record, _) => '${record.pestName}',
                color,
                "Pest Events",
                theme,
              );
      case 4: // Harvest - Column chart
        return tree.harvestRecords.isEmpty
            ? Center(child: Text("No data available for this chart"))
            : SfCartesianChart(
                palette: [color],
                title: ChartTitle(
                  text: chartTitles[index],
                  textStyle: textStyle,
                ),
                primaryXAxis: CategoryAxis(
                  labelStyle: textStyle.copyWith(fontSize: 12),
                  title: AxisTitle(text: 'Date', textStyle: textStyle),
                ),
                primaryYAxis: NumericAxis(
                  labelStyle: textStyle,
                  title: AxisTitle(
                    text: 'Harvest Amount',
                    textStyle: textStyle,
                  ),
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries>[
                  ColumnSeries<HarvestRecord, String>(
                    dataSource: tree.harvestRecords,
                    xValueMapper: (HarvestRecord record, _) =>
                          record.date.toString().substring(0, 16),
                    yValueMapper: (HarvestRecord record, _) => record.amount,
                    dataLabelSettings:  DataLabelSettings(isVisible: true, textStyle: textStyle),
                  ),
                ],
              );
      case 5: // Temperature - Spline chart
        return tree.temperatureRecords.isEmpty
            ? Center(child: Text("No data available for this chart"))
            : SfCartesianChart(
                palette: [color],
                title: ChartTitle(
                  text: chartTitles[index],
                  textStyle: textStyle,
                ),
                primaryXAxis: CategoryAxis(
                  labelStyle: textStyle.copyWith(fontSize: 12),
                  title: AxisTitle(text: 'Date', textStyle: textStyle),
                ),
                primaryYAxis: NumericAxis(
                  labelStyle: textStyle,
                  title: AxisTitle(
                    text: 'Temperature (°C)',
                    textStyle: textStyle,
                  ),
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries>[
                  SplineSeries<TemperatureRecord, String>(
                    dataSource: tree.temperatureRecords,
                    xValueMapper: (TemperatureRecord record, _) =>
                        record.date.toString().substring(0, 16),
                    yValueMapper: (TemperatureRecord record, _) =>
                        record.temperature,
                    markerSettings: const MarkerSettings(isVisible: true),
                      dataLabelSettings:  DataLabelSettings(isVisible: true, textStyle: textStyle),
                  ),
                ],
              );
      default:
        return Container();
    }
  }

  Widget _buildPieChart<T>(
    List<T> data,
    ChartValueMapper<T, num> valueMapper,
    ChartValueMapper<T, String> labelMapper,
    Color color,
    String title,
    ThemeData theme,
  ) {
    final textStyle = TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 24,
      fontFamily: 'Font',
      fontWeight: FontWeight.w500,
    );
    return SfCircularChart(
      title: ChartTitle(
        text: title,
        textStyle: textStyle,
      ),
      legend: Legend(
        isVisible: true,
        textStyle: textStyle,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CircularSeries>[
        PieSeries<T, String>(
          dataSource: data,
          xValueMapper: labelMapper,
          yValueMapper: valueMapper,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
            textStyle: theme.textTheme.bodySmall?.copyWith(color: Colors.white),
          ),
          pointColorMapper: (_, __) => color,
          explode: true,
          explodeIndex: 0,
          // Добавляем анимацию
          animationDuration: 1000,
          // Улучшаем отображение текста
          dataLabelMapper: (T data, _) => labelMapper(data, _)?.split('\n')[0],
        ),
      ],
    );
  }
}
