//
//  PartyOfElves.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import AoC2022Support
import NilCoalescingAssignmentOperators



// MARK: - Protocol

@objc
public protocol PartyOfElvesish : metacosmModelish, Modelish
{
	var elves: [Elfish] { get }
	
	var foodPacks: [FoodPackish] { get }
	
	var calorieCountedFoodPacks: CalorieCountedFoodPacksish { get }
	
	var elfWithMostCaloriesInFoodPack: Elfish? { get }
	var elvesWithMostCaloriesInFoodPacks: [Elfish] { get }
	var elfWithLeastCaloriesInFoodPack: Elfish? { get }
	var elvesWithLeastCaloriesInFoodPacks: [Elfish] { get }
}



// MARK: - Model

@objcMembers
public class PartyOfElves : metacosmModel, Model, PartyOfElvesish
{
	public typealias ProtocolType = PartyOfElvesish
	
	
	public override convenience init() {
		self.init(elves: [])
	}
	
	public init(elves: [Elfish], takingCalorieCountedFoodPacks calorieCountedFoodPacksModel: CalorieCountedFoodPacks? = nil)
	{
		_elves = .init(elves)
		_calorieCountedFoodPacksModel_lazyStorage =?? calorieCountedFoodPacksModel
		
		defer { _calorieCountedFoodPacks.owner = self }
		
		super.init()
	}
	
	
	@SurrogateArray public var elves: [Elfish]
	
	public var isEmpty: Bool { _elves.storage.isEmpty }
	
	public func add(elf newElf: Elfish) {
		_elves.storage.append(newElf)
		_calorieCountedFoodPacksModel.add(foodPack: newElf.foodPack)
	}
	
	public func add(elves newElves: [Elfish]) {
		_elves.storage.append(contentsOf: newElves)
		_calorieCountedFoodPacksModel.add(foodPacks: newElves.map(\.foodPack))
	}
	
	
	// MARK: - FoodPacks
	
	public var foodPacks: [FoodPackish] { _elves.storage.map(\.foodPack) }
	
	
	// MARK: - Calorie-Counted FoodPacks
	
	private var _calorieCountedFoodPacksModel_lazyStorage: CalorieCountedFoodPacks?
	private var _calorieCountedFoodPacksModel: CalorieCountedFoodPacks {
		_calorieCountedFoodPacksModel_lazyStorage ??= CalorieCountedFoodPacks(
			foodPacks: self.foodPacks,
			mostLimit: RecordCountLimit(value: 3),
			leastLimit: RecordCountLimit(value: 3)
		)
		return _calorieCountedFoodPacksModel_lazyStorage!
	}
	@SurrogateOfModel(\PartyOfElves._calorieCountedFoodPacksModel) public var calorieCountedFoodPacks: CalorieCountedFoodPacksish
	
	public var elfWithMostCaloriesInFoodPack: Elfish? {
		_calorieCountedFoodPacksModel.foodPacksWithMostCalories.first?.owner!
	}
	public var elvesWithMostCaloriesInFoodPacks: [Elfish] {
		_calorieCountedFoodPacksModel.foodPacksWithMostCalories.map(\.owner!)
	}
	public var elfWithLeastCaloriesInFoodPack: Elfish? {
		_calorieCountedFoodPacksModel.foodPacksWithLeastCalories.first?.owner!
	}
	public var elvesWithLeastCaloriesInFoodPacks: [Elfish] {
		_calorieCountedFoodPacksModel.foodPacksWithLeastCalories.map(\.owner!)
	}
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		return false
	}
}


// MARK: - Protocol Extensions



public extension PartyOfElvesish
{
	func surrogate() -> metacosmSurrogate & PartyOfElvesish {
		return surrogate() as! metacosmSurrogate & PartyOfElvesish
	}
}
