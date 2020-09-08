class RecipeModel {
  String label;
  String image;
  String source;
  String url;
  RecipeModel({this.image, this.label, this.source, this.url});

  // factory RecipeModel.froma7a(Map<String, dynamic> parsedJson) {
  //   return RecipeModel(
  //       image: parsedJson["image"],
  //       label: parsedJson["label"],
  //       source: parsedJson["source"],
  //       url: parsedJson["url"]);
  // }
}
