//
//  Day05.swift
//  AdventOfCode
//
//  Created by Joohee Kim on 12/6/25.
//

import Algorithms

struct Day05: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[String]] {
    data.split(separator: "\n\n").map {
      $0.split(separator: "\n").compactMap { String($0) }
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var allRanges: [ClosedRange<Int>] = []
    var freshIds = 0

    let ranges = entities[0]

    for range in ranges {
      if let closedRange = closedRange(from: range) {
        allRanges.append(closedRange)
      }
    }

    let ids = entities[1]

    for id in ids {
      if let idNum = Int(id) {
        let isInAnyRange = allRanges.contains { $0.contains(idNum) }
        if isInAnyRange { freshIds += 1 }
      }
    }

    return freshIds
  }

  func closedRange(from string: String) -> ClosedRange<Int>? {
    let parts = string.split(separator: "-")
    guard parts.count == 2,
          let lower = Int(parts[0].trimmingCharacters(in: .whitespaces)),
          let upper = Int(parts[1].trimmingCharacters(in: .whitespaces)),
          lower <= upper
    else {
      return nil
    }

    return lower...upper
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var allRanges: [ClosedRange<Int>] = []

    let ranges = entities[0]

    for range in ranges {
      if let closedRange = closedRange(from: range) {
        allRanges.append(closedRange)
      }
    }

    let sorted = allRanges.sorted { $0.lowerBound < $1.lowerBound }

    var merged: [ClosedRange<Int>] = []
    for range in sorted {
        if let last = merged.last, last.overlaps(range) || last.upperBound + 1 == range.lowerBound {
            merged[merged.count - 1] = last.lowerBound...max(last.upperBound, range.upperBound)
        } else {
            merged.append(range)
        }
    }

    let totalCount = merged.reduce(0) { $0 + ($1.upperBound - $1.lowerBound + 1) }

    return totalCount
  }
}
