//
//  main.swift
//  Puzzle1
//
//  Created by Cap'n Slipp on 12/24/22.
//

import Foundation
import RockPaperScissors



let inputFilename = "input.example"
//let inputFilename = "input"
let inputURL = Bundle.main.url(forResource: inputFilename, withExtension: "")!
let inputContents = try! String(contentsOf: inputURL)
let inputLines = inputContents.components(separatedBy: .newlines)

for inputLine in inputLines {
	guard !inputLine.isEmpty else { continue }
	
	let inputPieces = inputLine.split(separator: CharacterSet.whitespaces)
	guard inputPieces.count >= 2 else {
		fatalError("Line “\(inputLine)” does not contain at least 2 fields (whitespace-separated).")
	}
	
	let opponentShapeValue = Shape.Value(Character(inputPieces[0]))
	let responseShapeValue = Shape.Value(Character(inputPieces[1]))
	
	print("\(opponentShapeValue) -> \(responseShapeValue)")
}
