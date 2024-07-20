class Upload {
  final int id;
  final String title;
  String imgSrc, misclassTitle;
  bool isCorrect;
  double confidence;
  int inferenceTime;

  Upload({
    required this.id,
    required this.title,
    required this.imgSrc,
    this.misclassTitle = 'None',
    this.isCorrect = true,
    this.confidence = 0.95,
    this.inferenceTime = 3,
  });

  // converts from Upload to JSON format
  Map<String, dynamic> toJsonMap() => {
    'id': id,
    'title': title,
    'imgSrc': imgSrc,
    'misclassTitle': misclassTitle,
    'isCorrect' : isCorrect,
    'confidence': confidence,
    'inferenceTime' : inferenceTime,
  };

  // constructor from JSON format to Upload
  Upload.fromJson(Map<String, dynamic> json) :
        id = json['id'],
        title = json['title'],
        imgSrc = json['imgSrc'],
        misclassTitle = json['misclassTitle'],
        isCorrect = json['isCorrect'],
        confidence = json['confidence'],
        inferenceTime = json['inferenceTime'];
}

final List<Upload> uploadClasses = [
  Upload(
    id: 0,
    title: 'Angiectasia',
    imgSrc: 'assets/classes/0-angiectasia.jpg',
  ),
  Upload(
    id: 1,
    title: 'Erosion',
    imgSrc: 'assets/classes/1-erosion.jpg',
  ),
  Upload(
    id: 2,
    title: 'Foreign Body',
    imgSrc: 'assets/classes/2-foreign-body.jpg',
  ),
  Upload(
    id: 3,
    title: 'Ileocecal Valve',
    imgSrc: 'assets/classes/3-ileocecal-valve.jpg',
  ),
  Upload(
    id: 4,
    title: 'Lymphangiectasia',
    imgSrc: 'assets/classes/4-lymphangiectasia.jpg',
  ),
  Upload(
    id: 5,
    title: 'Normal Clean Mucosa',
    imgSrc: 'assets/classes/5-normal-clean-mucosa.jpg',
  ),
  Upload(
    id: 6,
    title: 'Pylorus',
    imgSrc: 'assets/classes/6-pylorus.jpg',
  ),
  Upload(
    id: 7,
    title: 'Reduced Mucosal View',
    imgSrc: 'assets/classes/7-reduced-mucosal-view.jpg',
  ),
  Upload(
    id: 8,
    title: 'Ulcer',
    imgSrc: 'assets/classes/8-ulcer.jpg',
  ),
];

List<Upload> simulatedUploads = [
  // Angiectasia
  Upload(id: 0, title: 'Angiectasia', imgSrc: 'assets/uploads/Angiectasia/angiectasia-1.jpg', isCorrect: true, confidence: 0.90, inferenceTime: 120),
  Upload(id: 0, title: 'Angiectasia', imgSrc: 'assets/uploads/Angiectasia/angiectasia-2.jpg', isCorrect: true, confidence: 0.85, inferenceTime: 130),
  Upload(id: 0, title: 'Angiectasia', imgSrc: 'assets/uploads/Angiectasia/angiectasia-3.jpg', isCorrect: true, confidence: 0.88, inferenceTime: 115),
  Upload(id: 0, title: 'Angiectasia', imgSrc: 'assets/uploads/Angiectasia/angiectasia-4.jpg', isCorrect: true, confidence: 0.92, inferenceTime: 110),
  Upload(id: 0, title: 'Angiectasia', imgSrc: 'assets/uploads/Angiectasia/angiectasia-5.jpg', isCorrect: false, misclassTitle: 'Erosion', confidence: 0.45, inferenceTime: 140),

  // Erosion
  Upload(id: 1, title: 'Erosion', imgSrc: 'assets/uploads/Erosion/erosion-1.jpg', isCorrect: true, confidence: 0.80, inferenceTime: 125),
  Upload(id: 1, title: 'Erosion', imgSrc: 'assets/uploads/Erosion/erosion-2.jpg', isCorrect: true, confidence: 0.83, inferenceTime: 135),
  Upload(id: 1, title: 'Erosion', imgSrc: 'assets/uploads/Erosion/erosion-3.jpg', isCorrect: true, confidence: 0.87, inferenceTime: 105),
  Upload(id: 1, title: 'Erosion', imgSrc: 'assets/uploads/Erosion/erosion-4.jpg', isCorrect: true, confidence: 0.82, inferenceTime: 115),
  Upload(id: 1, title: 'Erosion', imgSrc: 'assets/uploads/Erosion/erosion-5.jpg', isCorrect: true, confidence: 0.84, inferenceTime: 120),

  // Foreign Body
  Upload(id: 2, title: 'Foreign Body', imgSrc: 'assets/uploads/ForeignBody/foreign_body-1.jpg', isCorrect: true, confidence: 0.86, inferenceTime: 130),
  Upload(id: 2, title: 'Foreign Body', imgSrc: 'assets/uploads/ForeignBody/foreign_body-2.jpg', isCorrect: true, confidence: 0.89, inferenceTime: 110),
  Upload(id: 2, title: 'Foreign Body', imgSrc: 'assets/uploads/ForeignBody/foreign_body-3.jpg', isCorrect: true, confidence: 0.93, inferenceTime: 140),
  Upload(id: 2, title: 'Foreign Body', imgSrc: 'assets/uploads/ForeignBody/foreign_body-4.jpg', isCorrect: false, misclassTitle: 'Ileocecal Valve', confidence: 0.40, inferenceTime: 145),
  Upload(id: 2, title: 'Foreign Body', imgSrc: 'assets/uploads/ForeignBody/foreign_body-5.jpg', isCorrect: true, confidence: 0.91, inferenceTime: 125),

  // Ileocecal Valve
  Upload(id: 3, title: 'Ileocecal Valve', imgSrc: 'assets/uploads/IleocecalValve/ileocecal_valve-1.jpg', isCorrect: true, confidence: 0.85, inferenceTime: 130),
  Upload(id: 3, title: 'Ileocecal Valve', imgSrc: 'assets/uploads/IleocecalValve/ileocecal_valve-2.jpg', isCorrect: true, confidence: 0.87, inferenceTime: 135),
  Upload(id: 3, title: 'Ileocecal Valve', imgSrc: 'assets/uploads/IleocecalValve/ileocecal_valve-3.jpg', isCorrect: true, confidence: 0.88, inferenceTime: 115),
  Upload(id: 3, title: 'Ileocecal Valve', imgSrc: 'assets/uploads/IleocecalValve/ileocecal_valve-4.jpg', isCorrect: true, confidence: 0.90, inferenceTime: 125),
  Upload(id: 3, title: 'Ileocecal Valve', imgSrc: 'assets/uploads/IleocecalValve/ileocecal_valve-5.jpg', isCorrect: true, confidence: 0.92, inferenceTime: 120),

  // Lymphangiectasia
  Upload(id: 4, title: 'Lymphangiectasia', imgSrc: 'assets/uploads/Lymphangiectasia/lymphangiectasia-1.jpg', isCorrect: true, confidence: 0.84, inferenceTime: 130),
  Upload(id: 4, title: 'Lymphangiectasia', imgSrc: 'assets/uploads/Lymphangiectasia/lymphangiectasia-2.jpg', isCorrect: true, confidence: 0.85, inferenceTime: 140),
  Upload(id: 4, title: 'Lymphangiectasia', imgSrc: 'assets/uploads/Lymphangiectasia/lymphangiectasia-3.jpg', isCorrect: false, misclassTitle: 'Normal Clean Mucosa', confidence: 0.35, inferenceTime: 150),
  Upload(id: 4, title: 'Lymphangiectasia', imgSrc: 'assets/uploads/Lymphangiectasia/lymphangiectasia-4.jpg', isCorrect: true, confidence: 0.87, inferenceTime: 110),
  Upload(id: 4, title: 'Lymphangiectasia', imgSrc: 'assets/uploads/Lymphangiectasia/lymphangiectasia-5.jpg', isCorrect: true, confidence: 0.89, inferenceTime: 120),

  // Normal Clean Mucosa
  Upload(id: 5, title: 'Normal Clean Mucosa', imgSrc: 'assets/uploads/NormalCleanMucosa/normal_clean_mucosa-1.jpg', isCorrect: true, confidence: 0.95, inferenceTime: 100),
  Upload(id: 5, title: 'Normal Clean Mucosa', imgSrc: 'assets/uploads/NormalCleanMucosa/normal_clean_mucosa-2.jpg', isCorrect: true, confidence: 0.97, inferenceTime: 105),
  Upload(id: 5, title: 'Normal Clean Mucosa', imgSrc: 'assets/uploads/NormalCleanMucosa/normal_clean_mucosa-3.jpg', isCorrect: true, confidence: 0.94, inferenceTime: 95),
  Upload(id: 5, title: 'Normal Clean Mucosa', imgSrc: 'assets/uploads/NormalCleanMucosa/normal_clean_mucosa-4.jpg', isCorrect: true, confidence: 0.96, inferenceTime: 110),
  Upload(id: 5, title: 'Normal Clean Mucosa', imgSrc: 'assets/uploads/NormalCleanMucosa/normal_clean_mucosa-5.jpg', isCorrect: true, confidence: 0.93, inferenceTime: 115),

  // Pylorus
  Upload(id: 6, title: 'Pylorus', imgSrc: 'assets/uploads/Pylorus/pylorus-1.jpg', isCorrect: true, confidence: 0.88, inferenceTime: 120),
  Upload(id: 6, title: 'Pylorus', imgSrc: 'assets/uploads/Pylorus/pylorus-2.jpg', isCorrect: true, confidence: 0.89, inferenceTime: 125),
  Upload(id: 6, title: 'Pylorus', imgSrc: 'assets/uploads/Pylorus/pylorus-3.jpg', isCorrect: true, confidence: 0.86, inferenceTime: 130),
  Upload(id: 6, title: 'Pylorus', imgSrc: 'assets/uploads/Pylorus/pylorus-4.jpg', isCorrect: true, confidence: 0.90, inferenceTime: 115),
  Upload(id: 6, title: 'Pylorus', imgSrc: 'assets/uploads/Pylorus/pylorus-5.jpg', isCorrect: true, confidence: 0.85, inferenceTime: 140),

  // Reduced Mucosal View
  Upload(id: 7, title: 'Reduced Mucosal View', imgSrc: 'assets/uploads/ReducedMucosalView/reduced_mucosal_view-1.jpg', isCorrect: true, confidence: 0.92, inferenceTime: 100),
  Upload(id: 7, title: 'Reduced Mucosal View', imgSrc: 'assets/uploads/ReducedMucosalView/reduced_mucosal_view-2.jpg', isCorrect: true, confidence: 0.90, inferenceTime: 110),
  Upload(id: 7, title: 'Reduced Mucosal View', imgSrc: 'assets/uploads/ReducedMucosalView/reduced_mucosal_view-3.jpg', isCorrect: true, confidence: 0.91, inferenceTime: 105),
  Upload(id: 7, title: 'Reduced Mucosal View', imgSrc: 'assets/uploads/ReducedMucosalView/reduced_mucosal_view-4.jpg', isCorrect: false, misclassTitle: 'Pylorus', confidence: 0.33, inferenceTime: 130),
  Upload(id: 7, title: 'Reduced Mucosal View', imgSrc: 'assets/uploads/ReducedMucosalView/reduced_mucosal_view-5.jpg', isCorrect: true, confidence: 0.93, inferenceTime: 120),

  // Ulcer
  Upload(id: 8, title: 'Ulcer', imgSrc: 'assets/uploads/Ulcer/ulcer-1.jpg', isCorrect: true, confidence: 0.90, inferenceTime: 140),
  Upload(id: 8, title: 'Ulcer', imgSrc: 'assets/uploads/Ulcer/ulcer-2.jpg', isCorrect: true, confidence: 0.85, inferenceTime: 130),
  Upload(id: 8, title: 'Ulcer', imgSrc: 'assets/uploads/Ulcer/ulcer-3.jpg', isCorrect: false, misclassTitle: 'Erosion', confidence: 0.40, inferenceTime: 150),
  Upload(id: 8, title: 'Ulcer', imgSrc: 'assets/uploads/Ulcer/ulcer-4.jpg', isCorrect: true, confidence: 0.87, inferenceTime: 120),
  Upload(id: 8, title: 'Ulcer', imgSrc: 'assets/uploads/Ulcer/ulcer-5.jpg', isCorrect: true, confidence: 0.88, inferenceTime: 135),
];

