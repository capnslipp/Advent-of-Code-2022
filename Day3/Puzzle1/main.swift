//
//  main.swift
//  Day3-Puzzle1
//
//  Created by Cap'n Slipp on 1/4/23.
//

import Foundation



let puzzle = Puzzle1(inputMode: .example)

puzzle.run()
guard !puzzle.isInvalid else {
	fatalError("Error: Invalid \(puzzle)")
}

puzzle.output.print()
print("\n\n" + "Answer: \(puzzle.answerValue)")
