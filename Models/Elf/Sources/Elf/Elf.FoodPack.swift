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
	var foodItems: [FoodItemish] { get }
	
	var totalCalorieCountValue: Int { get }
}



// MARK: - Model

@objcMembers
public class FoodPack : metacosmModel, FoodPackish
{
	public override init() {
		_foodItems = []
	}
	
	public init(foodItems: [FoodItemish]) {
		_foodItems = foodItems
	}
	
	
	public var _foodItems: [FoodItemish] = []
	public var foodItems: [FoodItemish] { _foodItems.map{ $0.surrogate() } }
	
	public var isEmpty: Bool {
		_foodItems.isEmpty
	}
	
	func add(foodItem: FoodItemish) {
		_foodItems.append(foodItem)
	}
	
	func add(foodItems: [FoodItemish]) {
		_foodItems.append(contentsOf: foodItems)
	}
	
	
	var _totalCalorieCountValue: Int?
	public var totalCalorieCountValue: Int {
		_totalCalorieCountValue ??= {
			_foodItems.reduce(0) { totalValue, foodItem in
				totalValue + foodItem.calorieCount.value
			}
		}()
		return _totalCalorieCountValue!
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



public extension FoodPackish
{
	func surrogate() -> metacosmSurrogate & FoodPackish {
		return surrogate() as! metacosmSurrogate & FoodPackish
	}
}
