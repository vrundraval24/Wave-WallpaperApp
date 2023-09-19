class PhotoModel {
  String imageSrc;
  String imageAvgColor;

  PhotoModel({required this.imageSrc, required this.imageAvgColor});

  static PhotoModel fromJson(Map<String, dynamic> jsonPhoto){
    return PhotoModel(imageSrc: (jsonPhoto['src'])['portrait'], imageAvgColor: jsonPhoto['avg_color']);
  }
}
