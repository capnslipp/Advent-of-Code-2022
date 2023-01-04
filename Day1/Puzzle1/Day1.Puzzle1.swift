//
//  Day1.Puzzle1.swift
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
public protocol Puzzle1ish : Modelish, Puzzleish
{
	var highestCalorieCountElf: Elfish? { get }
	var highestCalorieCountElfCalorieCount: CalorieCountish? { get }
}



// MARK: - Model

@objcMembers
public class Puzzle1 : metacosmModel, Model, Puzzle1ish
{
	public typealias ProtocolType = Puzzle1ish
	
	
	@SurrogateProperty public var input: Inputish
	
	
	private lazy var _partyModel: PartyOfElves = createParty()
	@ModelProperty(\Puzzle1._partyModel) public var party: PartyOfElvesish
	
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
	
	
	public var highestCalorieCountElf: Elfish? { self.party.elfWithMostCaloriesInFoodPack }
	public var highestCalorieCountElfCalorieCount: CalorieCountish? { self.highestCalorieCountElf?.foodPack.totalCalorieCount }
	
	public static let invalidAnswerValue = Puzzle.invalidAnswerValue
	public var answerValue: Int { self.highestCalorieCountElfCalorieCount?.value ?? Self.invalidAnswerValue }
	
	
	private var _outputModel = Output()
	@ModelProperty(\Puzzle1._outputModel) public var output: Outputish
	
	
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
		
		for elf in _partyModel.elves {
			print("\(elf.name): \(elf.foodPack.totalCalorieCount.value) calories")
		}
		
		if let highestCalorieCountElf = _partyModel.elfWithMostCaloriesInFoodPack {
			print("Elf with highest calorie count in food pack: \(highestCalorieCountElf.name): \(highestCalorieCountElf.foodPack.totalCalorieCount.value) calories")
		} else {
			print("Elf with highest calorie count in food pack: N/A— no elves")
		}
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



public extension Puzzle1ish
{
	func surrogate() -> metacosmSurrogate & Puzzle1ish {
		return surrogate() as! metacosmSurrogate & Puzzle1ish
	}
}
