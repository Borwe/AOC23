import "dart:io";

int part1(List<String> lines) {
  final times = lines[0]
      .split(" ")
      .where((e) {
        try {
          int.parse(e);
          return true;
        } catch (e) {
          return false;
        }
      })
      .map((e) => int.parse(e))
      .toList();

  final distance = lines[1]
      .split(" ")
      .where((e) {
        try {
          int.parse(e);
          return true;
        } catch (e) {
          return false;
        }
      })
      .map((e) => int.parse(e))
      .toList();

  List<int> winTimes = [];
  for (var game = 0; game < times.length; game++) {
    final max = times[game];
    var count = 0;
    for (var t = 1; t < max; t++) {
      var d = t * (max - t);
      if (d > distance[game]) {
        count += 1;
      }
    }
    winTimes.add(count);
  }

  var result = 1;
  for (final n in winTimes) {
    result *= n;
  }
  return result;
}

int part2(List<String> lines) {
  final times = int.parse(lines[0].split(" ").where((e) {
    try {
      int.parse(e);
      return true;
    } catch (e) {
      return false;
    }
  }).join());

  final distance = int.parse(lines[1].split(" ").where((e) {
    try {
      int.parse(e);
      return true;
    } catch (e) {
      return false;
    }
  }).join());

  var count = 0;
  for (var t = 1; t < times; t++) {
    var d = t * (times - t);
    if (d > distance) {
      count += 1;
    }
  }

  return count;
}

void main() {
  final lines = File("./data/day6.txt").readAsLinesSync();
  print("Day 6");
  print("${part1(lines)}");
  print("${part2(lines)}");
}
