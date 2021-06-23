import '../models/journey_request_sort_criteria.dart';
import '../models/selection_item.dart';
import '../models/journey_request_search_dto.dart';

import '../models/engine_type.dart';

class JourneyHelper {
  static String getTimer(JourneyRequestSearchDto journeyRequest) {
    Duration duration = journeyRequest.endDateTime.difference(DateTime.now());
    String timerValue = '';

    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;

    if (duration.inDays > 0) {
      timerValue = duration.inDays.toString() + ' jours,';
    }
    if (hours >= 0 && hours <= 9) {
      timerValue += '0' + hours.toString() + ':';
    } else {
      timerValue += hours.toString() + ':';
    }
    if ((duration.inMinutes % 60) >= 0 && (duration.inMinutes % 60) <= 9) {
      timerValue += '0' + minutes.toString() + ':';
    } else {
      timerValue += minutes.toString() + ':';
    }
    if (duration.inSeconds >= 0 && duration.inSeconds <= 9) {
      timerValue += '0' + seconds.toString();
    } else {
      timerValue += seconds.toString();
    }
    return timerValue;
  }
}
