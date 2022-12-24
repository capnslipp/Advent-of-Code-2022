//
//  main.swift
//  Puzzle1
//
//  Created by Cap'n Slipp on 12/24/22.
//

import Foundation
import RockPaperScissors



var inputRounds: [(opponent: Shape.Value, response: Shape.Value)] = {
	let inputFilename = "input.example"
	//let inputFilename = "input"
	let inputURL = Bundle.main.url(forResource: inputFilename, withExtension: "")!
	let inputContents = try! String(contentsOf: inputURL)
	let inputLines = inputContents.components(separatedBy: .newlines)
	
	return inputLines.compactMap{ inputLine in
		guard !inputLine.isEmpty else { return nil }
		
		let inputPieces = inputLine.split(separator: CharacterSet.whitespaces)
		guard inputPieces.count >= 2 else {
			fatalError("Line “\(inputLine)” does not contain at least 2 fields (whitespace-separated).")
		}
		
		let opponentShapeValue = Shape.Value(Character(inputPieces[0]))
		let responseShapeValue = Shape.Value(Character(inputPieces[1]))
		return ( opponent: opponentShapeValue, response: responseShapeValue )
	}
}()
inputRounds.forEach{ print($0) }
