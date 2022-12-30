//
//  FoodItem.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import AoC2022Support



// MARK: - Protocol

@objc
public protocol FoodItemish : metacosmModelish
{
	var calorieCount: CalorieCountish { get }
}



// MARK: - Model

@objcMembers
public class FoodItem : metacosmModel, FoodItemish
{
	private override init() {
		fatalError("calorieCount not specified")
	}
	
	public init(calorieCount: CalorieCountish) {
		_calorieCount = .init(calorieCount)
	}
	
	public init(calorieCountValue: Int) {
		_calorieCount = .init(CalorieCount(value: calorieCountValue).surrogate())
	}
	
	
	@Surrogate public var calorieCount: CalorieCountish
	
	
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



public extension FoodItemish
{
	func surrogate() -> metacosmSurrogate & FoodItemish {
		return surrogate() as! metacosmSurrogate & FoodItemish
	}
}
