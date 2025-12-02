//
//  Day02.swift
//  AdventOfCode
//
//  Created by Joohee Kim on 12/2/25.
//

import Algorithms

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
    data.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var sum = 0

    for entity in entities {
      let range = entity.split(separator: "-").map { String($0) }
      let first = Int(range[0]) ?? 0
      let last = Int(range[1]) ?? 0

      for num in first...last {
        if isInvalidID(num) {
          sum += num
        }
      }
    }

    return sum
  }

  func isInvalidID(_ n: Int) -> Bool {
    let s = String(n)
    let length = s.count

    guard length % 2 == 0 else { return false }

    let halfLen = length / 2
    let firstHalf = s.prefix(halfLen)
    let secondHalf = s.suffix(halfLen)

    return firstHalf == secondHalf
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var sum = 0

    for entity in entities {
      let range = entity.split(separator: "-").map { String($0) }
      let first = Int(range[0]) ?? 0
      let last = Int(range[1]) ?? 0

      for num in first...last {
        if isInvalidIDLeast(num) {
          sum += num
        }
      }
    }

    return sum
  }

  func isInvalidIDLeast(_ n: Int) -> Bool {
    let s = String(n)
    let length = s.count

    guard length >= 2 else { return false }

    for patternLen in 1...(length / 2) {
      if length % patternLen == 0 {
        let pattern = String(s.prefix(patternLen))
        let repeatCount = length / patternLen
        let repeated = String(repeating: pattern, count: repeatCount)
        if repeated == s {
          return true
        }
      }
    }

    return false
  }
}
