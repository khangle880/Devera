import 'package:amplify_flutter/amplify.dart';
import 'package:asking/constants/asset_constants.dart';

class ImageUrlCache {
  ImageUrlCache._privateContructor();

  static final ImageUrlCache _instance = ImageUrlCache._privateContructor();

  static ImageUrlCache get instance => _instance;

  Map<String, String> _urlCache = Map();

  Future<String?> getUrl(String imageKey) async {
    String? url = _urlCache[imageKey];

    if (url == null) {
      try {
        url = (await Amplify.Storage.getUrl(key: imageKey)).url;
        _urlCache[imageKey] = url;
      } catch (e) {
        _urlCache[imageKey] = ImageConstants.defaultAvatar;
        print(e);
      }
    }

    return url;
  }
}
