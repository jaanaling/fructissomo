import 'package:fructissimo/src/feature/main/model/fertilizer.dart';
import 'package:fructissimo/src/feature/main/model/tree.dart';

class FertilizerRecommendation {
  String type;
  double amount;
  String method;
  int frequency;

  FertilizerRecommendation({
    required this.type,
    required this.amount,
    required this.method,
    required this.frequency,
  });
}

FertilizerRecommendation calculateFertilizer(TreeProfile tree) {
  // Определение потребностей дерева
  String purpose = fertilizerUsesForTrees[tree.health < 50 ? 5 : 0];
  List<Fertilizer> suitableFertilizers = fertilizers.where((fertilizer) {
    if (purpose == "Promote Healthy Growth") {
      return fertilizer.fertilizer.contains("Nitrogen");
    } else if (purpose == "Increase Disease Resistance") {
      return fertilizer.fertilizer.contains("Potassium") || fertilizer.fertilizer.contains("Calcium");
    } else if (purpose == "Enhance Root Development") {
      return fertilizer.fertilizer.contains("Phosphorus");
    } else {
      return fertilizer.fertilization >= 3;
    }
  }).toList();

  // Выбор лучшего удобрения
  Fertilizer selectedFertilizer = suitableFertilizers.isNotEmpty
      ? suitableFertilizers.first
      : fertilizers.first;

  // Расчет количества удобрения в фунтах
  double amount = (tree.diameter * selectedFertilizer.fertilization) / 2;

  // Определение метода внесения
  String method = tree.soil == "Sandy" ? "Frequent light applications" : "Standard application";

  // Определение частоты внесения
  int frequency = tree.health < 50 ? 30 : 60;

  return FertilizerRecommendation(
    type: selectedFertilizer.fertilizer,
    amount: amount,
    method: method,
    frequency: frequency,
  );
}
