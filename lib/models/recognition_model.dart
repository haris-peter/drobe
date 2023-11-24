class Recognition {
  final String? id;
  final String? project;
  final String? iteration;
  final String? created;
  final List<dynamic>? predictions;

  Recognition({
    this.id,
    this.project,
    this.iteration,
    this.created,
    this.predictions,
  });

  factory Recognition.fromJson(Map<String, dynamic> json) {
    return Recognition(
      id: json['id'] as String?,
      project: json['project'] as String?,
      iteration: json['iteration'] as String?,
      created: json['created'] as String?,
      predictions: json['predictions'] as List<dynamic>?,
    );
  }

  @override
  String toString() {
    String text = "";
    for (var prediction in predictions ?? []) {
      //print(prediction);
      if (prediction['probability'] is double &&
          prediction['probability'] > 0.3) {
        text = text +
            prediction['tagName'].toString() +
            " " +
            prediction['probability'].toString() +
            "\n";
      }
    }
    return text;
  }
}
