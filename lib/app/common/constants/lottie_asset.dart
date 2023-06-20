// ignore_for_file: library_private_types_in_public_api

const String _assets = 'assets';
const String _lootie = '$_assets/lottie';

class LottieAssetConstants {
  static _Lottie lottie = const _Lottie();
}

class _Lottie {
  const _Lottie();

  String get loadingSoccer => '$_lootie/soccer.json';
}
