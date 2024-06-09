import 'package:schuldaten_hub/common/filters/filters.dart';
import 'package:schuldaten_hub/common/utils/logger.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

class PupilTextFilter extends Filter<PupilProxy> {
  PupilTextFilter({
    required super.name,
  });

  String _text = '';
  String get text => _text;

  void setFilterText(String text) {
    _text = text;
    if (text.isEmpty) {
      toggle(false);
      notifyListeners();
      return;
    }
    toggle(true);
    logger.i('PupilTextFilter: setFilterText: $text');
    notifyListeners();
    return;
  }

  @override
  void reset() {
    _text = '';
    super.reset();
  }

  @override
  bool matches(PupilProxy item) {
    return item.internalId.toString().contains(text) ||
        item.firstName.toLowerCase().contains(text.toLowerCase()) ||
        item.lastName.toLowerCase().contains(text.toLowerCase());
  }
}
