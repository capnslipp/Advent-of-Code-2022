//
//  CalorieCountedFoodPacks.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import NilCoalescingAssignmentOperators



// MARK: - Protocol

@objc
public protocol CalorieCountedFoodPacksish : metacosmModelish
{
	var foodPacks: [FoodPackish] { get }
	
	var mostLimit: RecordCountLimitish { get }
	var leastLimit: RecordCountLimitish { get }
	
	var foodPacksWithMostCalories: [FoodPackish] { get }
	var foodPacksWithLeastCalories: [FoodPackish] { get }
}



// MARK: - Model

@objcMembers
public class CalorieCountedFoodPacks : metacosmModel, CalorieCountedFoodPacksish
{
	public override init() {
		self.mostLimit = RecordCountLimit()
		self.leastLimit = RecordCountLimit()
	}
	
	public init(foodPacks: [FoodPackish], mostLimit: RecordCountLimitish? = nil, leastLimit: RecordCountLimitish? = nil) {
		_foodPacks = foodPacks
		defer { queueRecalcOfFoodPacks() }
		
		self.mostLimit = mostLimit ?? RecordCountLimit()
		self.leastLimit = leastLimit ?? RecordCountLimit()
		
		super.init()
	}
	
	
	// MARK: `FoodPackish` Array
	
	public var _foodPacks: [FoodPackish] = []
	public var foodPacks: [FoodPackish] {
		get { _foodPacks.map{ $0.surrogate() } }
		set {
			_foodPacks = newValue
			queueRecalcOfFoodPacks()
		}
	}
	
	public var isEmpty: Bool {
		_foodPacks.isEmpty
	}
	
	
	// MARK: Limits
	
	public let mostLimit: RecordCountLimitish
	
	public let leastLimit: RecordCountLimitish
	
	
	// MARK: Calculated Most/Least Info
	
	public func queueRecalcOfFoodPacks() {
		_foodPacksWithMostCalories = nil
		_foodPacksWithLeastCalories = nil
	}
	
	private typealias FoodPackCalorieCountPair = ( foodPack: FoodPackish, calorieCount: CalorieCountish )
	private static let _noFoodPackCalorieCountSentinel: FoodPackCalorieCountPair = ( FoodPack().surrogate(), CalorieCount(value: CalorieCount.minimumValue).surrogate() )
	
	private var _foodPacksWithMostCalories: [FoodPackCalorieCountPair]? = nil
	public var foodPacksWithMostCalories: [FoodPackish] {
		if _foodPacksWithMostCalories == nil {
			recalcFoodPacksWithMostCalories()
		} else if self.mostLimit.value > _foodPacksWithMostCalories!.count {
			recalcFoodPacksWithMostCalories()
		}
		
		return _foodPacksWithMostCalories!.map{ $0.foodPack } as! [FoodPackish]
	}
	
	private func recalcFoodPacksWithMostCalories()
	{
		let mostLimitValue = self.mostLimit.value
		
		var highest: [FoodPackCalorieCountPair] = []
		
		for aFoodPack in _foodPacks {
			if highest.isEmpty {
				let newPair = ( aFoodPack, aFoodPack.totalCalorieCount )
				highest = [ newPair ]
			}
			else if (highest.count < mostLimitValue) || (aFoodPack.totalCalorieCount > highest.last!.calorieCount) {
				let newPair = ( aFoodPack, aFoodPack.totalCalorieCount )
				
				let justHigherThanValueAtIndex = (highest.lastIndex{ aFoodPack.totalCalorieCount < $0.calorieCount } ?? -1) + 1
				highest.insert(newPair, at: justHigherThanValueAtIndex)
			}
			
			if highest.count > mostLimitValue {
				highest.removeLast()
			}
		}
		
		_foodPacksWithMostCalories = highest
	}
	
	
	private var _foodPacksWithLeastCalories: [FoodPackCalorieCountPair]? = nil
	public var foodPacksWithLeastCalories: [FoodPackish] {
		if _foodPacksWithLeastCalories == nil {
			recalcFoodPacksWithLeastCalories()
		} else if self.leastLimit.value > _foodPacksWithLeastCalories!.count {
			recalcFoodPacksWithLeastCalories()
		}
		
		return _foodPacksWithLeastCalories!.map{ $0.foodPack } as! [FoodPackish]
	}
	
	private func recalcFoodPacksWithLeastCalories()
	{
		let leastLimitValue = self.leastLimit.value
		
		var lowest: [FoodPackCalorieCountPair] = []
		
		for aFoodPack in _foodPacks {
			if lowest.isEmpty {
				let newPair = ( aFoodPack, aFoodPack.totalCalorieCount )
				lowest = [ newPair ]
			}
			else if (lowest.count < leastLimitValue) || (aFoodPack.totalCalorieCount < lowest.last!.calorieCount) {
				let newPair = ( aFoodPack, aFoodPack.totalCalorieCount )
				
				let justLowerThanValueAtIndex = (lowest.lastIndex{ aFoodPack.totalCalorieCount > $0.calorieCount } ?? -1) + 1
				lowest.insert(newPair, at: justLowerThanValueAtIndex)
			}
			
			if lowest.count > leastLimitValue {
				lowest.removeLast()
			}
		}
		
		_foodPacksWithLeastCalories = lowest
	}
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		guard !isEmpty else { return true }
		return false
	}
}


// MARK: - Protocol Extensions



public extension CalorieCountedFoodPacksish
{
	func surrogate() -> metacosmSurrogate & CalorieCountedFoodPacksish {
		return surrogate() as! metacosmSurrogate & CalorieCountedFoodPacksish
	}
}
