import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/schoolday_events/models/schoolday_event.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';

class SchooldayEventFilterManager {
  ValueListenable<Map<SchooldayEventFilter, bool>>
      get schooldayEventsFilterState => _schooldayEventsFilterState;
  ValueListenable<bool> get schooldayEventsFiltersOn =>
      _schooldayEventsFiltersOn;
  ValueListenable<int> get filteredSchooldayEventsCount =>
      _filteredSchooldayEventsCount;

  final _schooldayEventsFilterState =
      ValueNotifier<Map<SchooldayEventFilter, bool>>(
          initialSchooldayEventFilterValues);
  final _schooldayEventsFiltersOn = ValueNotifier<bool>(false);
  final _filteredSchooldayEventsCount = ValueNotifier<int>(
      SchoolEventHelper.getSchooldayEventCount(
          locator<PupilFilterManager>().filteredPupils.value));
  SchooldayEventFilterManager() {
    logger.i('SchooldayEventFilterManager constructor called!');
  }

  resetFilters() {
    _schooldayEventsFilterState.value = {...initialSchooldayEventFilterValues};
    _schooldayEventsFiltersOn.value = false;
  }

  void setFilter(SchooldayEventFilter filter, bool isActive) {
    _schooldayEventsFilterState.value = {
      ..._schooldayEventsFilterState.value,
      filter: isActive,
    };
  }

  List<SchooldayEvent> schooldayEventsInTheLastSevenDays(PupilProxy pupil) {
    DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    List<SchooldayEvent> schooldayEvents = [];
    if (pupil.schooldayEvents != null) {
      for (SchooldayEvent schooldayEvent in pupil.schooldayEvents!) {
        if (schooldayEvent.schooldayEventDate.isBefore(sevenDaysAgo)) {
          schooldayEvents.add(schooldayEvent);
        }
      }
    }
    return schooldayEvents;
  }

  List<SchooldayEvent> schooldayEventsNotProcessed(PupilProxy pupil) {
    List<SchooldayEvent> schooldayEvents = [];
    if (pupil.schooldayEvents != null) {
      for (SchooldayEvent schooldayEvent in pupil.schooldayEvents!) {
        if (schooldayEvent.processedBy == null) {
          schooldayEvents.add(schooldayEvent);
        }
      }
    }
    return schooldayEvents;
  }

  List<SchooldayEvent> schooldayEventsInTheLastFourteenDays(PupilProxy pupil) {
    DateTime fourteenDaysAgo =
        DateTime.now().subtract(const Duration(days: 14));
    List<SchooldayEvent> schooldayEvents = [];
    if (pupil.schooldayEvents != null) {
      for (SchooldayEvent schooldayEvent in pupil.schooldayEvents!) {
        if (schooldayEvent.schooldayEventDate.isBefore(fourteenDaysAgo)) {
          schooldayEvents.add(schooldayEvent);
        }
      }
    }
    return schooldayEvents;
  }

  List<SchooldayEvent> filteredSchooldayEvents(PupilProxy pupil) {
    List<SchooldayEvent> filteredSchooldayEvents = [];
    DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    if (pupil.schooldayEvents != null) {
      final activeFilters = _schooldayEventsFilterState.value;
      for (SchooldayEvent schooldayEvent in pupil.schooldayEvents!) {
        // we keep the last seven days
        if (activeFilters[SchooldayEventFilter.sevenDays]! &&
            schooldayEvent.schooldayEventDate.isBefore(sevenDaysAgo)) {
          locator<PupilsFilter>().setFiltersOn(true);
          continue;
        }
        // we keep the not processed ones
        if (activeFilters[SchooldayEventFilter.processed]! &&
            schooldayEvent.processed == true) {
          _schooldayEventsFiltersOn.value = true;
          continue;
        }

        if (activeFilters[SchooldayEventFilter.redCard]! &&
            schooldayEvent.schooldayEventType != 'rk') {
          locator<PupilsFilter>().setFiltersOn(true);
          continue;
        }

        if (activeFilters[SchooldayEventFilter.redCardOgs]! &&
            schooldayEvent.schooldayEventType != 'rkogs') {
          locator<PupilsFilter>().setFiltersOn(true);
          continue;
        }
        if (activeFilters[SchooldayEventFilter.redCardsentHome]! &&
            schooldayEvent.schooldayEventType != 'rkabh') {
          locator<PupilsFilter>().setFiltersOn(true);
          continue;
        }
        if (activeFilters[SchooldayEventFilter.otherEvent]! &&
            schooldayEvent.schooldayEventType == 'other') {
          locator<PupilsFilter>().setFiltersOn(true);
          continue;
        }
        if (activeFilters[SchooldayEventFilter.parentsMeeting]! &&
            schooldayEvent.schooldayEventType != 'Eg') {
          locator<PupilsFilter>().setFiltersOn(true);
          continue;
        }
        if (activeFilters[SchooldayEventFilter.violenceAgainstPersons]! &&
            !schooldayEvent.schooldayEventReason.contains('gm')) {
          locator<PupilsFilter>().setFiltersOn(true);
          continue;
        }

        filteredSchooldayEvents.add(schooldayEvent);
      }

      // sort schooldayEvents, latest first
      filteredSchooldayEvents
          .sort((a, b) => b.schooldayEventDate.compareTo(a.schooldayEventDate));
      return filteredSchooldayEvents;
    }
    return [];
  }
}
