//
//  CalorieCountedFoodPacks.swift
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
public protocol CalorieCountedFoodPacksish : Modelish, metacosmModelish
{
	var foodPacks: [FoodPackish] { get }
	
	var mostLimit: RecordCountLimitish { get }
	var leastLimit: RecordCountLimitish { get }
	
	var foodPacksSortedByMostCalories: FoodPacksSortedish { get }
	var foodPacksWithMostCalories: [FoodPackish] { get }
	
	var foodPacksSortedByLeastCalories: FoodPacksSortedish { get }
	var foodPacksWithLeastCalories: [FoodPackish] { get }
}



// MARK: - Model

@objcMembers
public class CalorieCountedFoodPacks : metacosmModel, Model, CalorieCountedFoodPacksish
{
	public typealias ProtocolType = CalorieCountedFoodPacksish
	
	
	public override init() {
		_foodPacks = .init(wrappedValue: [])
		
		_mostLimit = .init(wrappedValue: RecordCountLimit())
		_leastLimit = .init(wrappedValue: RecordCountLimit())
	}
	
	public init(foodPacks: [FoodPackish], mostLimit: RecordCountLimitish? = nil, leastLimit: RecordCountLimitish? = nil) {
		_foodPacks = .init(wrappedValue: foodPacks)
		
		_mostLimit = .init(wrappedValue: mostLimit ?? RecordCountLimit())
		_leastLimit = .init(wrappedValue: leastLimit ?? RecordCountLimit())
		
		super.init()
	}
	
	
	// MARK: `FoodPackish` Array
	
	@SurrogateArray public var foodPacks: [FoodPackish] {
		didSet {
			_foodPacksSortedByMostCaloriesModel_lazyStorage?.replace(foodPacks: _foodPacks.storage)
			_foodPacksSortedByLeastCaloriesModel_lazyStorage?.replace(foodPacks: _foodPacks.storage)
		}
	}
	
	public func add(foodPack newFoodPack: FoodPackish) {
		_foodPacks.storage.append(newFoodPack)
	}
	
	public func add(foodPacks newFoodPacks: [FoodPackish]) {
		_foodPacks.storage.append(contentsOf: newFoodPacks)
	}
	
	public var isEmpty: Bool {
		_foodPacks.storage.isEmpty
	}
	
	
	// MARK: Limits
	
	@Surrogate public var mostLimit: RecordCountLimitish
	
	@Surrogate public var leastLimit: RecordCountLimitish
	
	
	// MARK: Calculated Most/Least Info
	
	var _foodPacksSortedByMostCaloriesModel_lazyStorage: FoodPacksSorted?
	var _foodPacksSortedByMostCaloriesModel: FoodPacksSorted {
		_foodPacksSortedByMostCaloriesModel_lazyStorage ??= FoodPacksSorted(
			foodPacks: _foodPacks.storage,
			comparator: { (earlier, later) in earlier.totalCalorieCount > later.totalCalorieCount },
			limit: self.mostLimit
		)
		return _foodPacksSortedByMostCaloriesModel_lazyStorage!
	}
	public var foodPacksSortedByMostCalories: FoodPacksSortedish { _foodPacksSortedByMostCaloriesModel.surrogate() }
	
	public var foodPacksWithMostCalories: [FoodPackish] { _foodPacksSortedByMostCaloriesModel.sortedFoodPacks }
	
	
	private var _foodPacksSortedByLeastCaloriesModel_lazyStorage: FoodPacksSorted?
	private var _foodPacksSortedByLeastCaloriesModel: FoodPacksSorted {
		_foodPacksSortedByLeastCaloriesModel_lazyStorage ??= FoodPacksSorted(
			foodPacks: _foodPacks.storage,
			comparator: { (earlier, later) in earlier.totalCalorieCount < later.totalCalorieCount },
			limit: self.leastLimit
		)
		return _foodPacksSortedByLeastCaloriesModel_lazyStorage!
	}
	public var foodPacksSortedByLeastCalories: FoodPacksSortedish { _foodPacksSortedByLeastCaloriesModel.surrogate() }
	
	public var foodPacksWithLeastCalories: [FoodPackish] { _foodPacksSortedByLeastCaloriesModel.sortedFoodPacks }
	
	
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
