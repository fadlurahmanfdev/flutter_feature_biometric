cd flutter_feature_biometric_platform_interface && fvm use 3.19.5 && fvm global 3.19.5 && flutter clean && flutter pub get && cd .. && \
  cd flutter_feature_biometric_android && fvm use 3.19.5 && flutter clean && flutter pub get && cd .. && \
  cd flutter_feature_biometric && fvm use 3.19.5 && flutter clean && flutter pub get && cd example && \
  fvm use 3.19.5 && flutter clean && flutter pub get && cd .. && cd ..