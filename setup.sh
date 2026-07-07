cd mark_platform_interface && rm -rf pubspec.lock && fvm use 3.41.6 && fvm global 3.41.6 && fvm flutter clean && fvm flutter pub get && cd .. && \
  cd mark_android && rm -rf pubspec.lock && fvm use 3.41.6 && fvm flutter clean && fvm flutter pub get && cd .. && \
  cd mark_ios && rm -rf pubspec.lock && fvm use 3.41.6 && fvm flutter clean && fvm flutter pub get && cd .. && \
  cd mark_biometric && rm -rf pubspec.lock && fvm use 3.41.6 && fvm flutter clean && fvm flutter pub get && \
  cd example && rm -rf pubspec.lock && fvm use 3.41.6 && fvm flutter clean && fvm flutter pub get && cd .. && cd ..