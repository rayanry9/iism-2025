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

enum Gender { men, women }

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

int getSportIdFromSport(Sports sport, int type, bool staff) {
  if (staff) {
    switch (sport) {
      case Sports.athletics:
        if (type == 1) {
          return -3;
        } else if (type == 2) {
          return -4;
        } else if (type == 3) {
          return -5;
        }
      case Sports.volleyball:
        return 25;
      case Sports.football:
        return 20;
      case Sports.cricket:
        return 19;
      case Sports.badminton:
        if (type == 1) {
          return 16;
        } else {
          return 17;
        }
      case Sports.basketball:
        return 18;
      case Sports.tennis:
        return 22;
      case Sports.squash:
        return 21;
      case Sports.tableTennis:
        if (type == 1) {
          return 23;
        } else {
          return 24;
        }
      case Sports.chess:
        return 59;
      default:
        return 0;
    }
  } else {
    switch (sport) {
      case Sports.athletics:
        if (type == 1) {
          return 0;
        } else if (type == 2) {
          return -1;
        } else if (type == 3) {
          return -2;
        }
      case Sports.volleyball:
        if (type == 1) {
          return 14;
        } else {
          return 15;
        }
      case Sports.football:
        return 7;
      case Sports.cricket:
        return 5;
      case Sports.hockey:
        return 6;
      case Sports.badminton:
        if (type == 1) {
          return 1;
        } else {
          return 2;
        }
      case Sports.basketball:
        if (type == 1) {
          return 3;
        } else {
          return 4;
        }
      case Sports.squash:
        if (type == 1) {
          return 8;
        } else {
          return 9;
        }
      case Sports.tableTennis:
        if (type == 1) {
          return 10;
        } else {
          return 11;
        }
      case Sports.tennis:
        if (type == 1) {
          return 12;
        } else {
          return 13;
        }
      default:
        return 1;
    }
  }
  return 1;
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

bool isSportIdMixed(int sportId) {
  return sportId == 58;
}

bool isSportIdFemale(int sportId) {
  switch (sportId) {
    case 2:
    case 4:
    case 9:
    case 11:
    case 13:
    case 15:
    case 17:
    case 24:
    case 45:
    case 46:
    case 47:
    case 48:
    case 49:
    case 50:
    case 51:
    case 52:
    case 53:
    case 54:
    case 55:
    case 56:
    case 57:
    case 62:
    case 76:
    case 77:
    case 78:
    case 79:
    case 80:
    case 81:
    case 82:
    case 83:
    case -1:
    case -4:
      return true;
    default:
      return false;
  }
}
