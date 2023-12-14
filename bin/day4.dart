import "dart:io";

int part1(List<String> lines) {
  int sum = 0;
  for (final line in lines) {
    int cardScore = 0;
    final numStarts = line.indexOf(":") + 1;
    final numsEnd = line.indexOf("|");

    final wins = line
        .substring(numStarts, numsEnd)
        .split(" ")
        .where((l) {
          switch (l) {
            case "":
              return false;
            default:
              return true;
          }
        })
        .map((l) => int.parse(l))
        .toList();

    final mines = line
        .substring(numsEnd + 1)
        .split(" ")
        .where((l) {
          switch (l) {
            case "":
              return false;
            default:
              return true;
          }
        })
        .map((l) => int.parse(l))
        .toList();

    for (final n in wins) {
      if (mines.contains(n)) {
        if (cardScore == 0) {
          cardScore = 1;
        } else {
          cardScore = cardScore * 2;
        }
      }
    }

    sum += cardScore;
  }
  return sum;
}

int part2(List<String> lines) {
  int sum = 0;
  List<int> copies = [];
  for (var i = 0; i < lines.length; i++) {
    sum += 1;

    //sum up multiples
    var multi = 0;
    if (copies.contains(i)) {
      for (var j = 0; j < copies.length; j++) {
        if (copies[j] == i) {
          sum += 1;
          multi += 1;
        }
      }
    }

    final line = lines[i];
    final numStarts = line.indexOf(":") + 1;
    final numsEnd = line.indexOf("|");

    final wins = line
        .substring(numStarts, numsEnd)
        .split(" ")
        .where((l) {
          switch (l) {
            case "":
              return false;
            default:
              return true;
          }
        })
        .map((l) => int.parse(l))
        .toList();

    final mines = line
        .substring(numsEnd + 1)
        .split(" ")
        .where((l) {
          switch (l) {
            case "":
              return false;
            default:
              return true;
          }
        })
        .map((l) => int.parse(l))
        .toList();

    var matches = i;
    for (final n in wins) {
      if (mines.contains(n)) {
        matches += 1;
        copies.add(matches);
        //handle for compies
        for (var x = 0; x < multi; x++) {
          copies.add(matches);
        }
      }
    }
  }
  return sum;
}

void main() {
  var lines = File("./data/day4.txt").readAsLinesSync();
  print("Day 4");
  print("${part1(lines)}");
  print("${part2(lines)}");
}
