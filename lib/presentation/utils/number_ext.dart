

import 'package:ssc/presentation/utils/device_size.dart';


extension DX on double {
  double get h => DeviceSize.height(this);
  double get w => DeviceSize.width(this);

  double get mh => this * (DeviceSize.maxHeight ?? 200);

  double get mw => this * (DeviceSize.maxWidth ?? 200);


}