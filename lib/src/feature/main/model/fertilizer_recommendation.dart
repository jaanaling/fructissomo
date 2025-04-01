import 'package:fructissimo/src/feature/main/model/fertilizer.dart';
import 'package:fructissimo/src/feature/main/model/tree.dart';

class FertilizerRecommendation {
  String fertilizerType;
  double amountInPounds;
  String applicationMethod;
  int frequencyInDays;

  FertilizerRecommendation({
    required this.fertilizerType,
    required this.amountInPounds,
    required this.applicationMethod,
    required this.frequencyInDays,
  });
}

FertilizerRecommendation calculateFertilizer(
    TreeProfile tree, String purpose, String vegetationType) {
  // Определение потребностей дерева (ввод вручную)

  List<Fertilizer> suitableFertilizers = fertilizers.where((fertilizer) {
    if (purpose == "Promote Healthy Growth") {
      return fertilizer.fertilizer.contains("Nitrogen");
    } else if (purpose == "Increase Disease Resistance") {
      return fertilizer.fertilizer.contains("Potassium") ||
          fertilizer.fertilizer.contains("Calcium");
    } else if (purpose == "Enhance Root Development") {
      return fertilizer.fertilizer.contains("Phosphorus");
    } else {
      return fertilizer.fertilization >= 3;
    }
  }).toList();

  // Дополнительные критерии по введенному типу растительности
  if (vegetationType == "Tropical") {
    suitableFertilizers
        .addAll(fertilizers.where((f) => f.fertilizer.contains("Potassium")));
  } else if (vegetationType == "Boreal") {
    suitableFertilizers
        .addAll(fertilizers.where((f) => f.fertilizer.contains("Phosphorus")));
  } else if (vegetationType == "Forest") {
    suitableFertilizers
        .addAll(fertilizers.where((f) => f.fertilizer.contains("Compost")));
  }

  // Выбор лучшего удобрения
  Fertilizer selectedFertilizer = suitableFertilizers.isNotEmpty
      ? suitableFertilizers.first
      : fertilizers.first;

  // Расчет количества удобрения в фунтах
  double amount = (tree.diameter * selectedFertilizer.fertilization) / 2;

  // Определение метода внесения
  String method = tree.soil == "Sandy"
      ? "Frequent light applications"
      : "Standard application";

  // Определение частоты внесения
  int frequency = tree.health < 50 ? 30 : 60;

  return FertilizerRecommendation(
    fertilizerType: selectedFertilizer.fertilizer,
    amountInPounds: amount,
    applicationMethod: method,
    frequencyInDays: frequency,
  );
}
