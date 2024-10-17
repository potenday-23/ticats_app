enum TicatsEventOrdering {
  ticketOpenData("오픈 다가온 순", "ticketOpenData"),
  recommend("추천순", "recommend"),
  point("인기순", "-point"),
  updatedDate("최근순", "-updatedDate"),
  endDate("공연마감순", "endDate");

  const TicatsEventOrdering(this.label, this.apiName);

  final String label;
  final String apiName;
}
