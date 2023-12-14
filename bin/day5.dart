import "dart:io";

class Range {
  int destination;
  int source;
  int range;

  Range(this.destination, this.source, this.range);

  @override
  String toString() {
    // TODO: implement toString
    return "$destination $source $range";
  }
}

int part1(List<String> lines) {
  var seeds =
      lines[0].substring(7).split(" ").map((v) => int.parse(v)).toList();
  var lIndex = 3;

  //parse the transformers
  List<List<Range>> transormers = [];
  List<Range> range = [];
  for (; lIndex < lines.length; lIndex++) {
    final line = lines[lIndex].trim();
    if (line.length == 0) {
      transormers.add(range);
      lIndex += 1;
      range = [];
      continue;
    }

    final opts = line.trim().split(" ").map((v) => int.parse(v)).toList();
    range.add(Range(opts[0], opts[1], opts[2]));
  }
  transormers.add(range);

  //map the seeds to location
  for (final transform in transormers) {
    seeds = seeds.map((s) {
      for (final r in transform) {
        if (s >= r.source && s < r.source + r.range) {
          return r.destination + (s - r.source);
        }
      }
      return s;
    }).toList();
  }

  var smallest = seeds[0];
  for (final n in seeds) {
    if (smallest > n) {
      smallest = n;
    }
  }
  return smallest;
}

int part2(List<String> lines) {
  //parse the transformers
  var lIndex = 3;
  List<List<Range>> transormers = [];
  List<Range> range = [];
  for (; lIndex < lines.length; lIndex++) {
    final line = lines[lIndex].trim();
    if (line.length == 0) {
      transormers.add(range);
      lIndex += 1;
      range = [];
      continue;
    }

    final opts = line.trim().split(" ").map((v) => int.parse(v)).toList();
    range.add(Range(opts[0], opts[1], opts[2]));
  }
  transormers.add(range);

  final seedsRanges =
      lines[0].substring(7).split(" ").map((v) => int.parse(v)).toList();
  var closestLocation = 0;

  for (var i = 0; i < seedsRanges[1]; i++) {
    var num = seedsRanges[0] + i;

    //map the num to location
    for (final transform in transormers) {
      for (final r in transform) {
        if (num >= r.source && num < r.source + r.range) {
          num = r.destination + (num - r.source);
          break;
        }
      }
    }

    if (i == 0) {
      closestLocation = num;
    } else {
      if (closestLocation > num) {
        closestLocation = num;
      }
    }
  }
  for (var i = 0; i < seedsRanges[3]; i++) {
    var num = seedsRanges[2] + i;

    //map the num to location
    for (final transform in transormers) {
      for (final r in transform) {
        if (num >= r.source && num < r.source + r.range) {
          num = r.destination + (num - r.source);
          break;
        }
      }
    }

    if (closestLocation > num) {
      closestLocation = num;
    }
  }

  for (var i = 0; i < seedsRanges[5]; i++) {
    var num = seedsRanges[4] + i;

    //map the num to location
    for (final transform in transormers) {
      for (final r in transform) {
        if (num >= r.source && num < r.source + r.range) {
          num = r.destination + (num - r.source);
          break;
        }
      }
    }

    if (closestLocation > num) {
      closestLocation = num;
    }
  }

  return closestLocation;
}

void main() {
  final lines = File("./data/day5.txt").readAsLinesSync();
  print("Day 5");
  print("${part1(lines)}");
  print("${part2(lines)}");
}
