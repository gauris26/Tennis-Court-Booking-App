import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/features/booking/infrastructure/network/weather_manager.dart';
import 'weather_manager_mock.dart';
import 'package:get_it/get_it.dart';

void main() {
  var getIt = GetIt.instance;
  group('Weather Manager Test', () {
    WeatherManagerMock weatherManagerMock = WeatherManagerMock();
    getIt.registerSingleton<WeatherManager>(weatherManagerMock);

    /*test("Firebase reference dependency is null", () async {
      // Given
      LoginService loginService = LoginService(null, null);

      //Then
      expect(await loginService.getCurrentUser(), isNull);
      verifyNever(firebaseMock.currentUser()).called(0);
    });*/
  });
}
