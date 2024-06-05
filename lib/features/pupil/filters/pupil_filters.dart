import 'package:schuldaten_hub/common/filters/filters.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

class PupilTextFilter extends Filter<PupilProxy> {
  PupilTextFilter({
    required super.name,
  });

  String _text = '';
  String get text => _text;

  void setFilterText(String text) {
    _text = text;
    toggle(isActive);
    notifyListeners();
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
