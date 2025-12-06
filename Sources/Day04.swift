//
//  Day04.swift
//  AdventOfCode
//
//  Created by Joohee Kim on 12/6/25.
//

import Algorithms

struct Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Character]] {
    data.split(separator: "\n").map { Array($0) }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    // Cache the grid once instead of recomputing it every access
    let grid = entities
    let rows = grid.count
    let cols = grid[0].count
    var rolls = 0

    for row in 0..<rows {
      for col in 0..<cols {
        if grid[row][col] == "@" && checkBoundary(row, col, grid: grid) {
          rolls += 1
        }
      }
    }

    return rolls
  }

  func checkBoundary(_ row: Int, _ col: Int, grid: [[Character]]) -> Bool {
    let rows = grid.count
    let cols = grid[0].count
    var count = 0

    // up
    if row - 1 >= 0 {
      if grid[row - 1][col] == "@" { count += 1 }
    }
    // down
    if row + 1 < rows {
      if grid[row + 1][col] == "@" { count += 1 }
    }
    // right
    if col + 1 < cols {
      if grid[row][col + 1] == "@" { count += 1 }
    }
    // left
    if col - 1 >= 0 {
      if grid[row][col - 1] == "@" { count += 1 }
    }
    // left-up
    if row - 1 >= 0 && col - 1 >= 0 {
      if grid[row - 1][col - 1] == "@" { count += 1 }
    }
    // right-up
    if row - 1 >= 0 && col + 1 < cols {
      if grid[row - 1][col + 1] == "@" { count += 1 }
    }
    // right-down
    if row + 1 < rows && col + 1 < cols {
      if grid[row + 1][col + 1] == "@" { count += 1 }
    }
    // left-down
    if row + 1 < rows && col - 1 >= 0 {
      if grid[row + 1][col - 1] == "@" { count += 1 }
    }

    return count < 4
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var currentGrid = entities
    let rows = currentGrid.count
    let cols = currentGrid[0].count
    var totalRolls = 0

    while true {
      var nextGrid = currentGrid
      var removedThisRound = 0

      for row in 0..<rows {
        for col in 0..<cols {
          if currentGrid[row][col] == "@" && checkBoundary(row, col, grid: currentGrid) {
            removedThisRound += 1
            nextGrid[row][col] = "."
          }
        }
      }

      if removedThisRound == 0 {
        break
      }

      totalRolls += removedThisRound
      currentGrid = nextGrid
    }

    return totalRolls
  }
}
