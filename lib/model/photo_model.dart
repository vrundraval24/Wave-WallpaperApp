class PhotoModel {
  final int imgWidth;
  final int imgHeight;
  final String imageSrc;
  final String imageAvgColor;
  final String highQualityFullScreenImages;

  PhotoModel(
      {required this.imageSrc,
      required this.imageAvgColor,
      required this.highQualityFullScreenImages, required this.imgWidth, required this.imgHeight});

  static PhotoModel fromJson(Map<String, dynamic> jsonPhoto) {
    return PhotoModel(
        imgWidth: jsonPhoto['width'],
        imgHeight: jsonPhoto['height'],
        imageSrc: (jsonPhoto['src'])['portrait'],
        imageAvgColor: jsonPhoto['avg_color'],
        highQualityFullScreenImages: (jsonPhoto['src'])['original'],
    );
  }
}
