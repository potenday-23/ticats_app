enum TicatsEventSortFilter {
  basic("기본순"),
  recommend("추천순"),
  point("인기순"),
  updatedDate("최근순"),
  endDate("공연마감순");

  const TicatsEventSortFilter(this.label);

  final String label;
}