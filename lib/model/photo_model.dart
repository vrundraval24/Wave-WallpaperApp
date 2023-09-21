class PhotoModel {
  String imageSrc;
  String imageAvgColor;
  String highQualityFullScreenImages;

  PhotoModel({required this.imageSrc, required this.imageAvgColor, required this.highQualityFullScreenImages});

  static PhotoModel fromJson(Map<String, dynamic> jsonPhoto){
    return PhotoModel(imageSrc: (jsonPhoto['src'])['portrait'], imageAvgColor: jsonPhoto['avg_color'], highQualityFullScreenImages: (jsonPhoto['src'])['original']);
  }
}
