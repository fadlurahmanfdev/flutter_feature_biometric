cd mark_platform_interface && fvm use 3.29.3 && fvm global 3.29.3 && fvm flutter clean && fvm flutter pub get && cd .. && \
  cd mark_android && fvm use 3.29.3 && fvm flutter clean && fvm flutter pub get && cd .. && \
  cd mark_ios && fvm use 3.29.3 && fvm flutter clean && fvm flutter pub get && cd .. && \
  cd mark && fvm use 3.29.3 && fvm flutter clean && fvm flutter pub get && \
  cd example && fvm use 3.29.3 && fvm flutter clean && fvm flutter pub get && cd .. && cd ..