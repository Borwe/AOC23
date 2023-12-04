import 'dart:collection';
import 'dart:io';

int part1(List<String> lines) {
  final rgb = HashMap.of({'r': 12, 'g': 13, 'b': 14});

  var games = List.of({0});
  for (final line in lines) {
    final p = line.split(RegExp(r"(Game|,|:|\s)")).where((l) {
      switch (l) {
        case "":
          return false;
        default:
          return true;
      }
    }).toList();

    var game = int.parse(p[0]);
    HashMap<String, int> balls = HashMap();
    var gameValid = true;
    for (var i = 1; i < p.length; i += 2) {
      if (gameValid == false) {
        break;
      }

      final color = p[i + 1][0];
      final score = int.parse(p[i]);
      if (balls[color] == null) {
        balls[color] = score;
      } else {
        balls[color] = balls[color]! + score;
      }

      if (p[i + 1].endsWith(";") || i + 2 >= p.length) {
        for (final k in rgb.keys) {
          if ((balls[k] ?? 0) > (rgb[k] ?? 0)) {
            gameValid = false;
            break;
          }
        }
        balls = HashMap();
      }
    }

    if (gameValid) {
      games.add(game);
    }
  }

  var sum = 0;
  for (final game in games) {
    sum += game;
  }
  return sum;
}

int part2(List<String> lines) {
  List<int> sumsPowers = [];

  for (final line in lines) {
    final p = line.split(RegExp(r"(Game|,|:|\s)")).where((l) {
      switch (l) {
        case "":
          return false;
        default:
          return true;
      }
    }).toList();

    HashMap<String, int> balls = HashMap();
    HashMap<String, int> turn = HashMap();
    for (var i = 1; i < p.length; i += 2) {
      final color = p[i + 1][0];
      final score = int.parse(p[i]);
      if (turn[color] == null) {
        turn[color] = score;
      } else {
        turn[color] = turn[color]! + score;
      }

      if (p[i + 1].endsWith(";") || i + 2 >= p.length) {
        for (final k in turn.keys) {
          if ((balls[k] ?? 0) < (turn[k] ?? 0)) {
            balls[k] = turn[k]!;
          }
        }
        turn = HashMap();
      }
    }

    var power = 1;
    for (final k in balls.keys) {
      power *= balls[k]!;
    }
    sumsPowers.add(power);
  }

  var sum = 0;
  for (final power in sumsPowers) {
    sum += power;
  }
  return sum;
}

void main() async {
  final lines = File("./data/day2.txt").readAsLinesSync();

  print("Day 2");
  print("Part 1: ${part1(lines)}");
  print("Part 2: ${part2(lines)}");
}
