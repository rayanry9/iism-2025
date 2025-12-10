enum Sports {
  football("Football"),
  cricket("Cricket"),
  volleyball("Volleyball"),
  hockey("Hockey"),
  athletics("Athletics"),
  badminton("Badminton"),
  basketball("Basketball"),
  squash("Squash"),
  chess("Chess"),
  tennis("Tennis"),
  tableTennis("Table Tennis");

  final String displayName;
  const Sports(this.displayName);
}

List<Sports> getSportsAll(bool staff) {
  if (!staff) {
    return [
      Sports.athletics,
      Sports.cricket,
      Sports.football,
      Sports.hockey,
      Sports.volleyball,
    ];
  } else {
    return [
      Sports.athletics,
      Sports.badminton,
      Sports.basketball,
      Sports.chess,
      Sports.cricket,
      Sports.football,
      Sports.tableTennis,
      Sports.tennis,
      Sports.volleyball,
      Sports.squash,
    ];
  }
}

/// Convert sportId → Sports enum (TS version translated to Dart)
Sports? getSportFromSportId(int id) {
  switch (id) {
    case -5:
    case -4:
    case -3:
    case -2:
    case -1:
    case 0:
      return Sports.athletics;

    case 1:
    case 2:
    case 16:
    case 17:
      return Sports.badminton;

    case 3:
    case 4:
    case 18:
      return Sports.basketball;

    case 5:
    case 19:
      return Sports.cricket;

    case 6:
      return Sports.hockey;

    case 7:
    case 20:
      return Sports.football;

    case 8:
    case 9:
    case 21:
      return Sports.squash;

    case 10:
    case 11:
    case 23:
    case 24:
      return Sports.tableTennis;

    case 12:
    case 13:
    case 22:
      return Sports.tennis;

    case 14:
    case 15:
    case 25:
      return Sports.volleyball;

    case 59:
      return Sports.chess;

    default:
      return null;
  }
}

String? getSportImageSrc(Sports? sport) {
  if (sport == null) return null;

  switch (sport) {
    case Sports.football:
      return "assets/sport/football.webp";
    case Sports.cricket:
      return "assets/sport/cricket.webp";
    case Sports.volleyball:
      return "assets/sport/volleyball.webp";
    case Sports.hockey:
      return "assets/sport/hockey.webp";
    case Sports.athletics:
      return "assets/sport/athletics.webp";
    case Sports.badminton:
      return "assets/sport/badminton.webp";
    case Sports.basketball:
      return "assets/sport/basketball.webp";
    case Sports.squash:
      return "assets/sport/squash.webp";
    case Sports.chess:
      return "assets/sport/chess.webp";
    case Sports.tennis:
      return "assets/sport/tennis.webp";
    case Sports.tableTennis:
      return "assets/sport/table-tennis.webp";
  }
}
