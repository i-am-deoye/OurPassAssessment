



enum AssetsType {
  images("images");

  final String value;
  const AssetsType(this.value);
}

class AssetsPath {
  static const String _path = "assets/";

  static String getPath(AssetsType assetsType) {
    return _path + assetsType.value;
  }
}