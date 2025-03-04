const String database_name = 'calculator';

const String table_name = 'memory';
const String column_code = 'code';
const String column_expression = 'expression';
const String column_result = 'result';
const String column_date = 'date';

const String create_table_script = '''
  CREATE TABLE $table_name
  (
    $column_code VARCHAR(36) PRIMARY KEY,
    $column_expression VARCHAR(400),
    $column_result DECIMAL(15,4),
    $column_date INTEGER
  )
''';

const int database_version = 1;
