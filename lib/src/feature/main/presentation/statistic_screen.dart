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
    "Temperature"
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
              AppAppBar(
                title: "Statistic",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(chartTitles.length, (index) {
                  return AppButton(
                    style: ButtonColors.green,
                    text: chartTitles[index],
                    onPressed: () => setState(() => selectedChartIndex = index),
                  );
                }),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(text: chartTitles[selectedChartIndex]),
                    series: _getChartSeries(tree, selectedChartIndex),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<CartesianSeries<dynamic, String>> _getChartSeries(
      TreeProfile tree, int index) {
    switch (index) {
      case 0:
        return [
          ColumnSeries<WateringRecord, String>(
            dataSource: tree.wateringRecords,
            xValueMapper: (record, _) => record.date.toString(),
            yValueMapper: (record, _) => record.amount,
          )
        ];
      case 1:
        return [
          ColumnSeries<FertilizationRecord, String>(
            dataSource: tree.fertilizationRecords,
            xValueMapper: (record, _) => record.date.toString(),
            yValueMapper: (record, _) => record.amount,
          )
        ];
      case 2:
        return [
          LineSeries<ProtectionRecord, String>(
            dataSource: tree.protectionRecords,
            xValueMapper: (record, _) => record.date.toString(),
            yValueMapper: (_, __) => 1,
          )
        ];
      case 3:
        return [
          LineSeries<PestRecord, String>(
            dataSource: tree.pestRecords,
            xValueMapper: (record, _) => record.date.toString(),
            yValueMapper: (_, __) => 1,
          )
        ];
      case 4:
        return [
          ColumnSeries<HarvestRecord, String>(
            dataSource: tree.harvestRecords,
            xValueMapper: (record, _) => record.date.toString(),
            yValueMapper: (record, _) => record.amount,
          )
        ];
      case 5:
        return [
          LineSeries<TemperatureRecord, String>(
            dataSource: tree.temperatureRecords,
            xValueMapper: (record, _) => record.date.toString(),
            yValueMapper: (record, _) => record.temperature,
          )
        ];
      default:
        return [];
    }
  }
}
