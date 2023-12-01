import "dart:collection";
import "dart:io";

import "package:test/test.dart";

int part1(final List<String> lines) {
  int sum = 0;
  for (final line in lines) {
    String iC = "";
    String jC = "";
    bool foundI = false;
    bool foundJ = false;

    for (var i = 0, j = line.length - 1;; i++, j--) {
      if (foundJ == true && foundI == true) {
        break;
      }
      if (int.tryParse(line[i]) != null && !foundI) {
        iC += line[i];
        foundI = true;
      }
      if (int.tryParse(line[j]) != null && !foundJ) {
        jC += line[j];
        foundJ = true;
      }
    }

    iC += jC;
    sum += int.parse(iC);
  }
  return sum;
}

class Pair {
  bool result;
  String? mWord;

  Pair({this.mWord, this.result = false});

  String get word => mWord ?? "";
}

int part2(final List<String> lines) {
  final startsWords = HashMap.of({
    'o': {"one"},
    't': {"two", "three"},
    'f': {"four", "five"},
    's': {"six", "seven"},
    'e': {"eight"},
    'n': {"nine"}
  });
  final endsWords = HashMap.of({
    'e': {"one", "three", "five", "nine"},
    'o': {"two"},
    'r': {"four"},
    'x': {"six"},
    't': {"eight"},
    'n': {"seven"}
  });

  final wordsToNum = HashMap.of({
    "one": "1",
    "two": "2",
    "three": "3",
    "four": "4",
    "five": "5",
    "six": "6",
    "seven": "7",
    "eight": "8",
    "nine": "9",
  });

  int numOfChars(final String val) => val.length;
  Pair isLastWord(final int index, final String val) {
    if (index >= val.length) {
      return Pair();
    }
    var char = val[index];
    final possibles = endsWords[char];
    if (possibles == null) return Pair();

    for (final word in possibles) {
      final wordLength = numOfChars(word);
      if (index - (wordLength - 1) < 0) {
        return Pair();
      }
      final cmp = val.substring(index - (wordLength - 1), index + 1);
      if (cmp == word) {
        return Pair(mWord: word, result: true);
      }
    }
    return Pair();
  }

  Pair isFirstWord(final int index, final String val) {
    if (index >= val.length) {
      return Pair();
    }
    var char = val[index];
    final possibles = startsWords[char];
    if (possibles == null) return Pair();

    for (final word in possibles) {
      final wordLength = numOfChars(word);
      if (index + wordLength + 1 > val.length) {
        continue;
      }

      final cmp = val.substring(index, index + wordLength);
      if (cmp == word) {
        return Pair(mWord: word, result: true);
      }
    }
    return Pair();
  }

  var sum = 0;
  for (final line in lines) {
    String iC = "";
    String jC = "";
    bool foundI = false;
    bool foundJ = false;

    for (var i = 0, j = line.length - 1; j >= 0 && i < line.length; i++, j--) {
      if (foundJ == true && foundI == true) {
        break;
      }

      final iP = isFirstWord(i, line);
      if (!foundI && iP.result) {
        iC += wordsToNum[iP.word] ?? "";
        foundI = true;
      }
      final iJ = isLastWord(j, line);
      if (!foundJ && iJ.result) {
        jC += wordsToNum[iJ.word] ?? "";
        foundJ = true;
      }
      if (int.tryParse(line[i]) != null && !foundI) {
        iC += line[i];
        foundI = true;
      }
      if (int.tryParse(line[j]) != null && !foundJ) {
        jC += line[j];
        foundJ = true;
      }
    }

    iC += jC;
    sum += int.parse(iC);
  }
  return sum;
}

void main(List<String> args) {
  final file = File("./data/day1.txt");
  final lines = file.readAsLinesSync();
  print("part 1: ${part1(lines)}");
  print("part 2: ${part2(lines)}");
}
