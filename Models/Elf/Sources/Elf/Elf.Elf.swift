//
//  Elf.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import With



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
		_foodPackModel = FoodPack(foodItems: [])
		defer { _foodPackModel.owner = self.surrogate() }
		
		super.init()
	}
	
	public init(name: String, takingFoodPack foodPackModel: FoodPack) {
		self.name = name
		
		_foodPackModel = foodPackModel
		defer { _foodPackModel.owner = self.surrogate() }
		
		super.init()
	}
	
	
	public let name: String
	
	var _foodPackModel: FoodPack
	public var foodPack: FoodPackish { _foodPackModel.surrogate() }
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		if let owner = self.foodPack.owner {
			guard (owner.surrogate() as! AnyHashable) == (self.surrogate() as! AnyHashable) else { return true }
		}
		return false
	}
	
	public override var isUnset: Bool {
		return false
	}
}


// MARK: - Protocol Extensions



public extension Elfish
{
	func surrogate() -> metacosmSurrogate & Elfish {
		return surrogate() as! metacosmSurrogate & Elfish
	}
}
