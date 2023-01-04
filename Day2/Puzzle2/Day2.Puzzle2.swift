//
//  Day2.Puzzle2.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import AoC2022Support
import RockPaperScissors
import Elf



// MARK: - Protocol

@objc
public protocol Puzzle2ish : Puzzleish, metacosmModelish
{
	var inputRoundPlans: [RoundShapeOutcomePlanish] { get }
	
	var myOutcome: VersusOutcomeish { get }
	var mePlayer: Playerish { get }
	var myTotalScore: Scoreish { get }

	var elfsShape: Shapeish { get }
	var elfPlayer: Elfish { get }
	var elfsTotalScore: Scoreish { get }
	
	var round: Roundish { get }
}



// MARK: - Model

@objcMembers
public class Puzzle2 : metacosmModel, Model, Puzzle2ish
{
	public typealias ProtocolType = Puzzle2ish
	
	
	@SurrogateProperty public var input: Inputish
	
	@SurrogateArrayProperty public var inputRoundPlans: [RoundShapeOutcomePlanish] = []
	
	
	private lazy var _myOutcomeModel = VersusOutcome()
	@ModelProperty(\Puzzle2._myOutcomeModel)
	public var myOutcome: VersusOutcomeish
	
	private lazy var _mePlayerModel = Player(
		name: "me",
		shape: DynamicShape{
			switch self.myOutcome.value {
				case .win:
					return self.elfsShape.value + 1
				case .lose:
					return self.elfsShape.value - 1
				case .draw:
					return self.elfsShape.value
				case .unset: return .unset
			}
		}
	)
	@ModelProperty(\Puzzle2._mePlayerModel)
	public var mePlayer: Playerish
	
	private lazy var _myTotalScoreModel = Score()
	@ModelProperty(\Puzzle2._myTotalScoreModel)
	public var myTotalScore: Scoreish
	
	
	private lazy var _elfsShapeModel = Shape()
	@ModelProperty(\Puzzle2._elfsShapeModel)
	public var elfsShape: Shapeish
	
	private lazy var _elfPlayerModel = Elf(name: "Opponent Elf", shape: self.elfsShape)
	@ModelProperty(\Puzzle2._elfPlayerModel)
	public var elfPlayer: Elfish
	
	private lazy var _elfsTotalScoreModel = Score()
	@ModelProperty(\Puzzle2._elfsTotalScoreModel)
	public var elfsTotalScore: Scoreish
	
	
	private lazy var _roundModel = Round(player1: mePlayer, player2: elfPlayer)
	@ModelProperty(\Puzzle2._roundModel)
	public var round: Roundish
	
	
	private var _outputModel = Output()
	@ModelProperty(\Puzzle2._outputModel) public var output: Outputish
	
	
	public static let invalidAnswerValue = Puzzle.invalidAnswerValue
	public var answerValue: Int {
		guard self.hasRun else { return Self.invalidAnswerValue }
		return Int(self.myTotalScore.value)
	}
	
	
	public private(set) var hasRun: Bool = false
	
	
	// MARK: Mutating Methods
	
	public func run()
	{
		defer { self.hasRun = true }
		
		_inputRoundPlans.storage = self.input.linesValue.compactMap{ inputLine in
			guard !inputLine.isEmpty else { return nil }
			
			let inputPieces = inputLine.split(separator: CharacterSet.whitespaces)
			guard inputPieces.count >= 2 else {
				fatalError("Line “\(inputLine)” does not contain at least 2 fields (whitespace-separated).")
			}
			
			return RoundShapeOutcomePlan(
				opponent: Shape.Value(Character(inputPieces[0])),
				response: VersusOutcome.Value(Character(inputPieces[1]))
			)
		}
		
		let out = _outputModel
		if !out.isBlank {
			out.clear()
		}
		let print = { string in out.addLine(value: string) }
		
		_myTotalScoreModel.value = Score.zeroValue
		_elfsTotalScoreModel.value = Score.zeroValue
		for roundPlan in _inputRoundPlans.storage {
			_roundModel.reset()
			
			_elfsShapeModel.value = roundPlan.opponentShapeValue
			_myOutcomeModel.value = roundPlan.responseValue
			
			_roundModel.play()
			
			_myTotalScoreModel.value += round.player1Score.value
			_elfsTotalScoreModel.value += round.player2Score.value
			
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
		_roundModel.reset()
		_elfsShapeModel.value = .unset
		_myOutcomeModel.value = .unset
		
		print("Final scores: \(mePlayer.name): \(myTotalScore.value) vs. \(elfPlayer.name): \(elfsTotalScore.value)")
		if myTotalScore > elfsTotalScore {
			print("Battle Winner: \(mePlayer.name)")
		} else if elfsTotalScore > myTotalScore {
			print("Battle Winner: \(elfPlayer.name)")
		} else {
			print("Battle Winner: draw")
		}
	}
	
	
	// MARK: Initialization/Deinitialization
	
	public init(input: Inputish)
	{
		_input = .init(input)
		
		defer { _myOutcome.owner = self }
		defer { _mePlayer.owner = self }
		defer { _myTotalScore.owner = self }
		defer { _elfsShape.owner = self }
		defer { _elfPlayer.owner = self }
		defer { _elfsTotalScore.owner = self }
		defer { _round.owner = self }
		defer { _output.owner = self }
		
		super.init()
	}
	
	public convenience init(inputMode: Input.ModeValue)
	{
		self.init(input: Input(mode: inputMode))
	}
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.input.isInvalid else { return true }
		guard !self.output.isInvalid else { return true }
		guard self.answerValue != Self.invalidAnswerValue else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		guard self.hasRun else { return false }
		guard !self.input.isUnset else { return true }
		guard !self.output.isUnset else { return true }
		return false
	}
}


// MARK: - Protocol Extensions



public extension Puzzle2ish
{
	func surrogate() -> metacosmSurrogate & Puzzle2ish {
		return surrogate() as! metacosmSurrogate & Puzzle2ish
	}
}
