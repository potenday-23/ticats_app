// ignore_for_file: constant_identifier_names

enum TicatsEventCategory {
  ALL("전체"),
  CONCERT("콘서트"),
  DRAMA("연극"),
  EXHIBIT("전시회"),
  MUSICAL("뮤지컬");

  const TicatsEventCategory(this.label);

  final String label;
}
