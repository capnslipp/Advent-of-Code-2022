//
//  main.swift
//  Day1-Puzzle2
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation



let puzzle = Puzzle2(inputMode: .real)

puzzle.run()
guard !puzzle.isInvalid else {
	fatalError("Error: Invalid \(puzzle)")
}

puzzle.output.print()
print("\n\n" + "Answer: \(puzzle.answerValue)")
