class DBConst {
  static const String dbName = 'notes_database.db';
  static const int dbVersion = 1;

  static const String tableName = 'Notes';
  static const String colId = '_id';
  static const String colTitle = 'heading';
  static const String colDescription = 'content';
  static const String colTime = 'lastEdit';
  static const String colPrimary = 'primaryColor';
  static const String colSecondary = 'secondaryColor';
  static const String _colorType = 'TEXT NOT NULL';
  static const String _idType = 'INTEGER PRIMARY KEY';
  static const String _textType = 'TEXT NOT NULL';

  static const List<String> columNames = [
    colId,
    colTitle,
    colDescription,
    colTime,
    colPrimary,
    colSecondary
  ];

  static const String orderByTime = '$colTime ASC';

  static const String createTableCommand = '''
CREATE TABLE $tableName(
  $colId $_idType,
  $colTitle $_textType,
  $colDescription $_textType,
  $colTime $_textType,
  $colPrimary $_colorType,
  $colSecondary $_colorType
)
''';

  static const String deleteEverythingCommand = 'DELETE FROM $tableName';
}
