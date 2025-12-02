//
//  Day01.swift
//  swift-aoc-2025
//
//  Created by Joohee Kim on 12/2/25.
//

import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
    data.split(separator: "\n").compactMap { String($0) }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var dial = 50   // 0~99
    var count = 0
    for entity in entities {
      let chars = Array(entity)
      let direction = String(chars[0])
      let steps = Int(String(chars[1...])) ?? 0

      if direction == "L" {
        // Left rotation: subtract and wrap around using modulo
        dial = ((dial - steps) % 100 + 100) % 100
      } else {
        // Right rotation: add and wrap around using modulo
        dial = (dial + steps) % 100
      }

      if dial == 0 { count += 1 }
    }

    return count
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var dial = 50   // 0~99
    var count = 0
    for entity in entities {
      let chars = Array(entity)
      let direction = String(chars[0])
      let steps = Int(String(chars[1...])) ?? 0

      if direction == "L" {
        if dial == 0 {
          count += steps / 100
        } else if dial > 0 {
          if steps >= dial {
            let q = (steps - dial) / 100 + 1
            count += q
          } else {
            count += 0
          }
        }
        dial = ((dial - steps) % 100 + 100) % 100
      } else {
        // Right rotation: add and wrap around using modulo
        let q = (dial + steps) / 100
        dial = (dial + steps) % 100
        count += q
      }
    }

    return count
  }
}
