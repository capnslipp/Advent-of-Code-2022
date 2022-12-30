//
//  FoodPacksSorted.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import AoC2022Support



// MARK: - Protocol

@objc
public protocol FoodPacksSortedish : metacosmModelish
{
	var foodPacks: [FoodPackish] { get }
	
	var limit: RecordCountLimitish { get }
	
	var sortedFoodPacks: [FoodPackish] { get }
}



// MARK: - Model

@objcMembers
public class FoodPacksSorted : metacosmModel, FoodPacksSortedish
{
	private override init() {
		fatalError("private init (comparator not specified)")
	}
	
	public init(foodPacks: [FoodPackish], comparator: @escaping FoodPackComparator, limit: RecordCountLimitish? = nil) {
		_foodPacks = .init(foodPacks)
		defer { queueRecalcOfSortedFoodPacks() }
		
		self.comparator = comparator
		_limit = .init(limit ?? RecordCountLimit())
		
		super.init()
	}
	
	
	// MARK: `FoodPackish` Array
	
	@SurrogateArray public var foodPacks: [FoodPackish] {
		didSet { queueRecalcOfSortedFoodPacks() }
	}
	
	public func replace(foodPacks: [FoodPackish]) {
		_foodPacks.storage = foodPacks
	}
	
	
	// MARK: Closures
	
	/// Should return true when `earlier` should be sorted before `later`, and false otherwise.
	public typealias FoodPackComparator = (_ earlier: FoodPackish, _ later: FoodPackish) -> Bool
	public var comparator: FoodPackComparator
	
	
	// MARK: Limit
	
	@Surrogate public var limit: RecordCountLimitish
	
	
	// MARK: Calculated Most/Least Info
	
	public func queueRecalcOfSortedFoodPacks() {
		_foodPacksSorted = nil
	}
	
	private static let _noFoodPackSentinel: FoodPackish = FoodPack().surrogate()
	
	private var _foodPacksSorted: [FoodPackish]? = nil
	public var sortedFoodPacks: [FoodPackish] {
		if _foodPacksSorted == nil {
			recalcFoodPacksSorted()
		} else if self.limit.value > _foodPacksSorted!.count {
			recalcFoodPacksSorted()
		}
		
		return _foodPacksSorted!
	}
	
	private func recalcFoodPacksSorted()
	{
		let limitValue = self.limit.value
		
		var earliest: [FoodPackish] = []
		
		for aFoodPack in _foodPacks.storage {
			if earliest.isEmpty {
				earliest = [ aFoodPack ]
			}
			else if (earliest.count < limitValue) || self.comparator(aFoodPack, earliest.last!) {
				let justHigherThanValueAtIndex = (earliest.lastIndex{ self.comparator($0, aFoodPack) } ?? -1) + 1
				earliest.insert(aFoodPack, at: justHigherThanValueAtIndex)
			}
			
			if earliest.count > limitValue {
				earliest.removeLast()
			}
		}
		
		_foodPacksSorted = earliest
	}
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		guard !_foodPacks.storage.isEmpty else { return true }
		return false
	}
}


// MARK: - Protocol Extensions



public extension FoodPacksSortedish
{
	func surrogate() -> metacosmSurrogate & FoodPacksSortedish {
		return surrogate() as! metacosmSurrogate & FoodPacksSortedish
	}
}
