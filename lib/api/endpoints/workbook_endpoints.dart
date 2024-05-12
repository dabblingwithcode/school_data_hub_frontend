class EndpointsWorkbook {
  static const getWorkbooks = '/workbooks/all/flat';
  static const getWorkbooksWithPupils = '/workbooks/all';

  String getWorkbook(int isbn) {
    return '/workbooks/$isbn';
  }

  static const postWorkbook = '/workbooks/new';

  String patchWorkbook(int isbn) {
    return '/workbooks/$isbn';
  }

  String patchWorkbookWithImage(int isbn) {
    return '/workbooks/$isbn/image';
  }

  String getWorkbookImage(int isbn) {
    return '/workbooks/$isbn/image';
  }

  String deleteWorkbook(int isbn) {
    return '/workbooks/$isbn';
  }
}
