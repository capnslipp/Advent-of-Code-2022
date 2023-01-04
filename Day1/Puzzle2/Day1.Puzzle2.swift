//
//  Day1.Puzzle2.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import AoC2022Support
import Elf



// MARK: - Protocol

@objc
public protocol Puzzle2ish : Modelish, Puzzleish
{
	var highestCalorieCountFoodPackElves: [Elfish] { get }
	var totalOfHighestCalorieCountFoodPacks: Int { get }
}



// MARK: - Model

@objcMembers
public class Puzzle2 : metacosmModel, Model, Puzzle2ish
{
	public typealias ProtocolType = Puzzle2ish
	
	
	@SurrogateProperty public var input: Inputish
	
	
	private lazy var _partyModel: PartyOfElves = createParty()
	@ModelProperty(\Puzzle2._partyModel) public var party: PartyOfElvesish
	
	private func createParty() -> PartyOfElves
	{
		var elfLinesBuffer: [String] = []
		var elves: [Elfish] = []
		
		for inputLine in self.input.linesValue {
			if !inputLine.isEmpty {
				elfLinesBuffer.append(inputLine)
			} else {
				elves.append(createElf(fromLines: elfLinesBuffer))
				elfLinesBuffer = []
			}
		}
		if !elfLinesBuffer.isEmpty {
			elves.append(createElf(fromLines: elfLinesBuffer))
		}
		
		return PartyOfElves(elves: elves)
	}
	
	private var _elfNameCounter = 1
	private func createElf(fromLines lines: [String]) -> Elf
	{
		let foodItems = lines.map{ Int($0)! }.map{ FoodItem(calorieCountValue: $0) }
		defer { _elfNameCounter += 1 }
		return Elf(
			name: "Elf #\(_elfNameCounter)",
			takingFoodPack: FoodPack(
				foodItems: foodItems
			)
		)
	}
	
	
	public var highestCalorieCountFoodPackElves: [Elfish] { self.party.elvesWithMostCaloriesInFoodPacks }
	public var totalOfHighestCalorieCountFoodPacks: Int {
		self.highestCalorieCountFoodPackElves.map(\.foodPack.totalCalorieCount.value).reduce(0){ $0 + $1 } 
	}
	
	public static let invalidAnswerValue = Puzzle.invalidAnswerValue
	public var answerValue: Int { self.totalOfHighestCalorieCountFoodPacks }
	
	
	private var _outputModel = Output()
	@ModelProperty(\Puzzle2._outputModel) public var output: Outputish
	
	
	public private(set) var hasRun: Bool = false
	
	
	// MARK: Mutating Methods
	
	public func run()
	{
		defer { self.hasRun = true }
		
		let out = _outputModel
		if !out.isBlank {
			out.clear()
		}
		let print = { string in out.addLine(value: string) }
		
		for elf in party.elves {
			print("\(elf.name): \(elf.foodPack.totalCalorieCount.value) calories")
		}
		
		let highestCalorieCountFoodPackElves = party.elvesWithMostCaloriesInFoodPacks
		print("Elves with highest calorie count in food pack: ")
		for anElf in highestCalorieCountFoodPackElves {
			print("\(anElf.foodPack.totalCalorieCount.value) calories")
		}
		let totalOfHighestCalorieCountFoodPacks = highestCalorieCountFoodPackElves.map(\.foodPack.totalCalorieCount.value).reduce(0){ $0 + $1 }
		print("Total: \(totalOfHighestCalorieCountFoodPacks)")

		let lowestCalorieCountFoodPackElves = party.elvesWithLeastCaloriesInFoodPacks
		print("Elves with lowest calorie count in food pack: ")
		for anElf in lowestCalorieCountFoodPackElves {
			print("\(anElf.foodPack.totalCalorieCount.value) calories")
		}
		let totalOfLowestCalorieCountFoodPacks = lowestCalorieCountFoodPackElves.map(\.foodPack.totalCalorieCount.value).reduce(0){ $0 + $1 }
		print("Total: \(totalOfLowestCalorieCountFoodPacks)")
	}
	
	
	// MARK: Initialization/Deinitialization
	
	public init(input: Inputish)
	{
		_input = .init(input)
		
		defer { _party.owner = self }
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
