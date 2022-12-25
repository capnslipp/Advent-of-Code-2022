//
//  main.swift
//  Puzzle1
//
//  Created by Cap'n Slipp on 12/24/22.
//

import Foundation
import RockPaperScissors
import Elf



var inputRounds: [(opponent: Shape.Value, response: Shape.Value)] = {
	//let inputFilename = "input.example"
	let inputFilename = "input"
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


let myShape = Shape()
let mePlayer = Player(name: "me", shape: myShape)
let myTotalScore = Score()

let elfsShape = Shape()
let elfPlayer = Elf(name: "Opponent Elf", shape: elfsShape)
let elfsTotalScore = Score()

let round = Round(player1: mePlayer, player2: elfPlayer)
for inputRound in inputRounds {
	round.reset()
	
	elfsShape.value = inputRound.opponent
	myShape.value = inputRound.response
	
	round.play()
	
	myTotalScore.value += round.player1Score.value
	elfsTotalScore.value += round.player2Score.value
	
	print(
		"\(round.player1.name)\(round.player1Outcome.value == .win ? "✨" : "") " +
		"with \(round.player1.shape.value) " +
		"vs. \(round.player2.name)\(round.player2Outcome.value == .win ? "✨" : "") " +
		"with \(round.player2.shape.value):"
	)
	if round.winnerPlayer == Round.drawPlayerSentinel {
		print("\t"+"Draw")
	} else {
		print("\t"+"Winner is \(round.winnerPlayer.name)")
	}
	print(
		"\(round.player1.name) scored \(round.player1Score.value) (\(round.player1.shape.score.value) + \(round.player1Outcome.score.value)) " +
		"& \(round.player2.name) scored \(round.player2Score.value) (\(round.player2.shape.score.value) + \(round.player2Outcome.score.value))"
	)
	print("")
}

print("Final scores: \(mePlayer.name): \(myTotalScore.value) vs. \(elfPlayer.name): \(elfsTotalScore.value)")
if myTotalScore > elfsTotalScore {
	print("Battle Winner: \(mePlayer.name)")
} else if elfsTotalScore > myTotalScore {
	print("Battle Winner: \(elfPlayer.name)")
} else {
	print("Battle Winner: draw")
}
