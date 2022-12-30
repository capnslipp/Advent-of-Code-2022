//
//  FoodPack.swift
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
public protocol FoodPackish : metacosmModelish
{
	var owner: Elfish? { get }
	
	var foodItems: [FoodItemish] { get }
	
	var totalCalorieCount: CalorieCountish { get }
}



// MARK: - Model

@objcMembers
public class FoodPack : metacosmModel, FoodPackish
{
	public init(owner: Elfish? = nil, foodItems: [FoodItemish] = []) {
		self.owner = owner
		_foodItems = .init(foodItems)
		
		super.init()
		
		_totalCalorieCount = .init(get: self._totalCalorieCountModel)
	}
	
	
	public var owner: Elfish?
	
	
	@SurrogateArray public var foodItems: [FoodItemish]
	
	public var isEmpty: Bool { _foodItems.storage.isEmpty }
	
	func add(foodItem: FoodItemish) {
		_foodItems.storage.append(foodItem)
		_totalCalorieCountValue = nil
	}
	
	func add(foodItems: [FoodItemish]) {
		_foodItems.storage.append(contentsOf: foodItems)
		_totalCalorieCountValue = nil
	}
	
	
	var _totalCalorieCountValue: Int?
	
	lazy var _totalCalorieCountModel = DynamicCalorieCount{ [self] in
		_totalCalorieCountValue ??= {
			_foodItems.storage.reduce(0) { totalValue, foodItem in
				totalValue + foodItem.calorieCount.value
			}
		}()
		return _totalCalorieCountValue!
	}
	@ModelSurrogate<DynamicCalorieCount, CalorieCountish> public var totalCalorieCount: CalorieCountish
	
	
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



public extension FoodPackish
{
	func surrogate() -> metacosmSurrogate & FoodPackish {
		return surrogate() as! metacosmSurrogate & FoodPackish
	}
}
