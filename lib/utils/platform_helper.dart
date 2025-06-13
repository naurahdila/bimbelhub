// utils/platform_helper.dart

import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' as io;

class PlatformHelper {
  static bool get isIOS {
    if (kIsWeb) {
      return false; // Tidak bisa mendeteksi iOS di web
    } else {
      return _isIOSPlatform();
    }
  }

  static bool _isIOSPlatform() {
    try {
      return io.Platform.isIOS;
    } catch (_) {
      return false;
    }
  }
}
