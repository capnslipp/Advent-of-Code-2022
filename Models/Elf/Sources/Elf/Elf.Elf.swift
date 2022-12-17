//
//  Elf.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol Elfish : metacosmModelish
{
	var name: String { get }
	
	var foodPack: FoodPackish { get }
}



// MARK: - Model

@objcMembers
public class Elf : metacosmModel, Elfish
{
	public override init() {
		self.name = ""
		_foodPack = FoodPack(foodItems: [])
	}
	
	public init(name: String, foodPack: FoodPackish) {
		self.name = name
		_foodPack = foodPack
	}
	
	
	public let name: String
	
	var _foodPack: FoodPackish
	public var foodPack: FoodPackish { _foodPack.surrogate() }
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		return true
	}
}


// MARK: - Protocol Extensions



public extension Elfish
{
	func surrogate() -> metacosmSurrogate & Elfish {
		return surrogate() as! metacosmSurrogate & Elfish
	}
}
