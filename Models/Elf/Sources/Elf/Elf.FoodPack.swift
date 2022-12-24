//
//  FoodPack.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import NilCoalescingAssignmentOperators



// MARK: - Protocol

@objc
public protocol FoodPackish : metacosmModelish
{
	var owner: Elfish? { get }
	
	var foodItems: [FoodItemish] { get }
	
	var totalCalorieCount: DynamicCalorieCountish { get }
}



// MARK: - Model

@objcMembers
public class FoodPack : metacosmModel, FoodPackish
{
	public override init() {
		_foodItems = []
	}
	
	public init(owner: Elfish? = nil, foodItems: [FoodItemish]) {
		self.owner = owner
		_foodItems = foodItems
	}
	
	
	public var owner: Elfish?
	
	
	public var _foodItems: [FoodItemish] = []
	public var foodItems: [FoodItemish] { _foodItems.map{ $0.surrogate() } }
	
	public var isEmpty: Bool {
		_foodItems.isEmpty
	}
	
	func add(foodItem: FoodItemish) {
		_foodItems.append(foodItem)
		_totalCalorieCountValue = nil
	}
	
	func add(foodItems: [FoodItemish]) {
		_foodItems.append(contentsOf: foodItems)
		_totalCalorieCountValue = nil
	}
	
	
	var _totalCalorieCountValue: Int?
	
	lazy var _totalCalorieCount = DynamicCalorieCount{ [self] in
		_totalCalorieCountValue ??= {
			_foodItems.reduce(0) { totalValue, foodItem in
				totalValue + foodItem.calorieCount.value
			}
		}()
		return _totalCalorieCountValue!
	}
	public var totalCalorieCount: DynamicCalorieCountish { _totalCalorieCount.surrogate() }
	
	
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
