//
//  Day03.swift
//  AdventOfCode
//
//  Created by Joohee Kim on 12/6/25.
//

import Algorithms

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
    return data.split(separator: "\n").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var total = 0

    for entity in entities {
      let digits = Array(entity).compactMap { $0.wholeNumberValue }

      var maxJoltage = 0
      for i in 0..<digits.count {
        for j in (i+1)..<digits.count {
          let joltage = digits[i] * 10 + digits[j]
          maxJoltage = max(maxJoltage, joltage)
        }
      }

      total += maxJoltage
    }

    return total
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var total = 0

    for entity in entities {
      let digits = Array(entity).compactMap { $0.wholeNumberValue }
      let n = digits.count
      let k = 12  // number of batteries to select

      // Greedy approach: for each position, pick the largest digit
      // from the valid range that leaves enough digits for the rest
      var result = [Int]()
      var startIndex = 0

      for position in 0..<k {
        let remaining = k - position  // how many more digits we need (including current)
        let endIndex = n - remaining  // last index we can pick from

        // Find the maximum digit in the valid range
        var maxDigit = -1
        var maxIndex = startIndex
        for i in startIndex...endIndex {
          if digits[i] > maxDigit {
            maxDigit = digits[i]
            maxIndex = i
          }
        }

        result.append(maxDigit)
        startIndex = maxIndex + 1
      }

      let joltage = Int(result.map { String($0) }.joined()) ?? 0
      total += joltage
    }

    return total
  }
}
