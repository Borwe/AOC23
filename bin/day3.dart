import "dart:io";

class Point {
  int mX;
  int mY;

  Point(x, y)
      : mX = x,
        mY = y;
}

class Nums {
  int num;
  Point p;
  int width;

  Nums(this.num, this.p, this.width);

  static Nums? from(List<String> lines, int x, int y) {
    if (int.tryParse(lines[y][x]) == null) {
      return null;
    }

    //go left till no longer can get number
    var left = x;
    while (true) {
      if (int.tryParse(lines[y][left]) == null) {
        if (left != x) {
          left++;
        }
        break;
      }
      if (left - 1 < 0) {
        break;
      }
      left--;
    }

    //go to right till no longer get number
    var right = x;
    for (; right < lines[y].length; right++) {
      if (int.tryParse(lines[y][right]) == null) {
        break;
      }
    }

    final p = Point(left, y);
    final width = right - left;
    final n = int.parse(lines[y].substring(left, right));

    //print("NUM: $n");
    if (n == 449) {
      print("${lines[y]}");
    }

    return Nums(n, p, width);
  }

  bool isSameAtPoint(Nums n) => p.mX == n.p.mX && p.mY == n.p.mY;
}

int part1(List<String> lines) {
  List<Nums> nums = [];
  List<Point> points = [];
  for (var y = 0; y < lines.length; ++y) {
    for (var x = 0; x < lines[y].length; ++x) {
      if (lines[y][x] != '.' && int.tryParse(lines[y][x]) == null) {
        points.add(Point(x, y));
      }
    }
  }

  for (final p in points) {
    print("${p.mX}, ${p.mY}");
    List<Nums?> numsSearch = [];
    //north
    if (p.mY - 1 >= 0) {
      numsSearch.add(Nums.from(lines, p.mX, p.mY - 1));
    }

    //neast
    if (p.mY - 1 >= 0 && p.mX + 1 < lines[0].length) {
      numsSearch.add(Nums.from(lines, p.mX + 1, p.mY - 1));
    }

    //east
    if (p.mX + 1 < lines[0].length) {
      numsSearch.add(Nums.from(lines, p.mX + 1, p.mY));
    }

    //seast
    if (p.mY + 1 < lines.length && p.mX + 1 < lines[0].length) {
      numsSearch.add(Nums.from(lines, p.mX + 1, p.mY + 1));
    }

    //south
    if (p.mY + 1 < lines.length) {
      numsSearch.add(Nums.from(lines, p.mX, p.mY + 1));
    }

    //swest
    if (p.mY + 1 < lines.length && p.mX - 1 > 0) {
      numsSearch.add(Nums.from(lines, p.mX - 1, p.mY + 1));
    }

    //west
    if (p.mX - 1 >= 0) {
      numsSearch.add(Nums.from(lines, p.mX - 1, p.mY));
    }

    //nwest
    if (p.mY - 1 >= 0 && p.mY - 1 >= 0) {
      numsSearch.add(Nums.from(lines, p.mX - 1, p.mY - 1));
    }

    for (final num in numsSearch) {
      if (num != null) {
        var match = false;
        for (final n in nums) {
          if (n.isSameAtPoint(num)) {
            match = true;
          }
        }
        if (match == false) {
          nums.add(num);
        }
      }
    }
  }

  var sum = 0;
  for (final n in nums) {
    sum += n.num;
  }
  return sum;
}

void main() {
  final lines = File("./data/day3.txt").readAsLinesSync();

  print("Part1: ${part1(lines)}");
}
