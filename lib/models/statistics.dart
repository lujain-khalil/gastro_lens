import 'upload.dart';

int countByClass(List<Upload> list, int id) {
  List<Upload> filtered = list.where((upload) => upload.id == id).toList();
  return filtered.length;
}

// confidence of prediction
String avgConfidence(List<Upload> list) {
  double result = (list.map((upload) => upload.confidence).reduce((a, b) => a + b) / list.length)*100;
  return (result).toStringAsFixed((result == 100 || result == 0) ? 0 : 1);
}
String avgConfidenceByClass(List<Upload> list, int id) {
  List<Upload> filtered = list.where((upload) => upload.id == id).toList();
  double result = (filtered.map((upload) => upload.confidence).reduce((a, b) => a + b) / filtered.length)*100;
  return (result).toStringAsFixed((result == 100 || result == 0) ? 0 : 1);
}

// classification accuracy of model
String avgAccuracy(List<Upload> list) {
  List<Upload> filteredCorrect = list.where((upload) => upload.isCorrect).toList();
  double result = (filteredCorrect.length / list.length)*100;
  return (result).toStringAsFixed((result == 100 || result == 0) ? 0 : 1);
}
String avgAccuracyByClass(List<Upload> list, int id) {
  List<Upload> filtered = list.where((upload) => upload.id == id).toList();
  List<Upload> filteredCorrect = filtered.where((upload) => upload.isCorrect).toList();
  double result = (filteredCorrect.length / filtered.length)*100;
  return (result).toStringAsFixed((result == 100 || result == 0) ? 0 : 1);
}

String avgF1Score(List<Upload> list) {
  List<String> classF1Scores = [];
  Set<int> uniqueIds = list.map((upload) => upload.id).toSet();
  for (int id in uniqueIds) {classF1Scores.add(avgF1ScoreByClass(list, id));}
  double totalF1Score = classF1Scores.fold(0, (sum, score) => sum + double.parse(score));
  double result = totalF1Score/uniqueIds.length;
  return (result).toStringAsFixed((result == 100 || result == 0) ? 0 : 1);
}

String avgF1ScoreByClass(List<Upload> list, int id) {
  int truePositives = 0;
  int falsePositives = 0;
  int falseNegatives = 0;
  for (var upload in list) {
    if (upload.id == id) {
      (upload.isCorrect) ? truePositives++ : falseNegatives++;
    } else if (upload.misclassTitle == list.firstWhere((element) => element.id == id).title) {
      falsePositives++;
    }
  }
  double precision = truePositives / (truePositives + falsePositives == 0 ? 1 : truePositives + falsePositives);
  double recall = truePositives / (truePositives + falseNegatives == 0 ? 1 : truePositives + falseNegatives);
  double result = (2 * (precision * recall) / (precision + recall == 0 ? 1 : precision + recall))*100;
  return (result).toStringAsFixed((result == 100 || result == 0) ? 0 : 1);
}

// inference time of model prediction
String avgInferenceTime(List<Upload> list) {
  return (list.map((upload) => upload.inferenceTime).reduce((a, b) => a + b) / list.length).toStringAsFixed(1);
}
String avgInferenceTimeByClass(List<Upload> list, int id) {
  List<Upload> filtered = list.where((upload) => upload.id == id).toList();
  return (filtered.map((upload) => upload.inferenceTime).reduce((a, b) => a + b) / filtered.length).toStringAsFixed(1);
}

class Tuple<T1, T2, T3> {
  final T1 item1;
  final T2 item2;
  final T3 item3;

  Tuple(this.item1, this.item2, this.item3);
}