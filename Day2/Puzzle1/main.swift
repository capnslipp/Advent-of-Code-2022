//
//  main.swift
//  Day2-Puzzle1
//
//  Created by Cap'n Slipp on 12/24/22.
//

import Foundation



let puzzle = Puzzle1(inputMode: .real)

puzzle.run()
guard !puzzle.isInvalid else {
	fatalError("Error: Invalid \(puzzle)")
}

puzzle.output.print()
print("\n\n" + "Answer: \(puzzle.answerValue)")
