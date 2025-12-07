//
//  Day06.swift
//  AdventOfCode
//
//  Created by Joohee Kim on 12/7/25.
//

import Algorithms

struct Day06: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
    data.split(separator: "\n").map { String($0) }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    let problems = entities.map { $0.split(separator: " ").map(String.init) }
    var total = 0
    let rows = problems.count
    let cols = problems[0].count
    let operators = problems[rows-1]

    for col in 0..<cols {
      var problem = Int(problems[0][col]) ?? 0
      let op = operators[col]
      for row in 1..<rows-1 {
        let val = Int(problems[row][col]) ?? 0
        if op == "+" {
          problem += val
        } else if op == "*" {
          problem *= val
        }
      }
      total += problem
    }

    return total
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    let lines = entities

    // Pad all rows to same length
    let maxLen = lines.map { $0.count }.max() ?? 0
    let grid = lines.map { row in
      Array(row) + Array(repeating: Character(" "), count: maxLen - row.count)
    }

    let numRows = grid.count
    let operatorRow = grid[numRows - 1]

    // Find all operator positions
    var operatorPositions: [(position: Int, op: Character)] = []
    for (i, ch) in operatorRow.enumerated() {
      if ch == "*" || ch == "+" {
        operatorPositions.append((i, ch))
      }
    }

    var total = 0

    for (idx, (opPos, op)) in operatorPositions.enumerated() {
      // Problem spans from opPos to next operator position - 1 (or end of row)
      let endPos: Int
      if idx + 1 < operatorPositions.count {
        endPos = operatorPositions[idx + 1].position - 1
      } else {
        endPos = maxLen - 1
      }

      // Collect numbers from columns opPos to endPos, reading right-to-left
      var numbers: [Int] = []

      for col in stride(from: endPos, through: opPos, by: -1) {
        var digitChars: [Character] = []
        var hasDigit = false

        for row in 0..<(numRows - 1) {
          let ch = grid[row][col]
          if ch.isNumber {
            hasDigit = true
            digitChars.append(ch)
          }
        }

        if hasDigit {
          let numStr = String(digitChars)
          if let num = Int(numStr) {
            numbers.append(num)
          }
        }
      }

      // Apply operator to all numbers
      if !numbers.isEmpty {
        var result = numbers[0]
        for i in 1..<numbers.count {
          if op == "+" {
            result += numbers[i]
          } else if op == "*" {
            result *= numbers[i]
          }
        }
        total += result
      }
    }

    return total
  }
}
