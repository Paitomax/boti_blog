import 'current_date_interface.dart';

class CurrentDateTime extends CurrentDateTimeInterface {
  @override
  DateTime now() {
    return DateTime.now();
  }
}
