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
		defer { recalcFoodPackWithMostCaloriesInFoodPack() }
		
		self.mostLimit = mostLimit ?? RecordCountLimit()
		self.leastLimit = leastLimit ?? RecordCountLimit()
		
		super.init()
	}
	
	
	// MARK: `FoodPackish` Array
	
	public var _foodPacks: [FoodPackish] = []
	public var foodPacks: [FoodPackish] { _foodPacks.map{ $0.surrogate() } }
	
	public var isEmpty: Bool {
		_foodPacks.isEmpty
	}
	
	
	// MARK: Limits
	
	public private(set) var mostLimit: RecordCountLimitish
	
	public private(set) var leastLimit: RecordCountLimitish
	
	
	// MARK: Calculated Most/Least Info
	
	private typealias FoodPackCalorieCountPair = ( foodPack: FoodPackish, calorieCount: CalorieCountish )
	private static let _noFoodPackCalorieCountSentinel: FoodPackCalorieCountPair = ( FoodPack().surrogate(), CalorieCount(value: CalorieCount.minimumValue).surrogate() )
	
	private var _foodPacksWithMostCalories: [FoodPackCalorieCountPair]? = nil
	private func recalcFoodPackWithMostCaloriesInFoodPack() {
		_foodPacksWithMostCalories = nil
	}
	public var foodPacksWithMostCalories: [FoodPackish] {
		let mostLimitValue = self.mostLimit.value
		
		_foodPacksWithMostCalories ??= {
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
			
			return highest
		}()
		
		return _foodPacksWithMostCalories!.map{ $0.foodPack } as! [FoodPackish]
	}
	
	
	private var _foodPacksWithLeastCalories: [FoodPackCalorieCountPair]? = nil
	private func recalcFoodPackWithLeastCaloriesInFoodPack() {
		_foodPacksWithLeastCalories = nil
	}
	public var foodPacksWithLeastCalories: [FoodPackish] {
		let leastLimitValue = self.leastLimit.value
		
		_foodPacksWithLeastCalories ??= {
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
			
			return lowest
		}()
		
		return _foodPacksWithLeastCalories!.map{ $0.foodPack } as! [FoodPackish]
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
