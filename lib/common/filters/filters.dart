import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';

abstract class Filter<T extends Object> with ChangeNotifier {
  Filter({
    required this.name,
    this.displayNameActive,
    this.displayNameInactive,
  });

  final String name;
  final String? displayNameActive;
  final String? displayNameInactive;

  Color get color => isActive ? Colors.blue : Colors.grey;

  String get displayName =>
      isActive ? displayNameActive ?? name : displayNameInactive ?? name;

  bool _isActive = false;
  bool get isActive => _isActive;

  void reset() {
    _isActive = false;
    notifyListeners();
  }

  void toggle() {
    _isActive = !_isActive;
    notifyListeners();
    locator<PupilsFilter>().refreshs();
  }

  bool matches(T item);
}

class SelectorFilter<T extends Object, V extends Object> extends Filter<T> {
  SelectorFilter({
    required super.name,
    required this.selector,
    super.displayNameActive,
    super.displayNameInactive,
  });

  final V Function(T) selector;

  @override
  bool matches(T item) {
    return selector(item) == name;
  }
}

class TextFilter extends SelectorFilter<String, String> {
  TextFilter({
    required String name,
    this.filterText = '',
    required String Function(String) selector,
    super.displayNameActive,
    super.displayNameInactive,
  }) : super(
          name: name,
          selector: selector,
        );

  String filterText = '';

  void setFilterText(String text) {
    filterText = text;
    notifyListeners();
  }
}
