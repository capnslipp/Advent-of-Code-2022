//
//  Elf.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import AoC2022Support
import With
import RockPaperScissors



// MARK: - Protocol

@objc
public protocol Elfish : metacosmModelish, Modelish, RockPaperScissors.Playerish
{
	var name: String { get }
	
	var foodPack: FoodPackish { get }
}



// MARK: - Model

@objcMembers
public class Elf : metacosmModel, Model, Elfish
{
	public typealias ProtocolType = Elfish
	
	
	private init(name: String, takingFoodPack foodPackModel: FoodPack? = nil, shape: Shapeish? = nil)
	{
		self.name = name
		
		_foodPackModel = foodPackModel ?? FoodPack(foodItems: [])
		defer { _foodPackModel.owner = self.surrogate() }
		defer { _foodPack.owner = self }
		
		let shape = shape ?? Shape(.unset).surrogate()
		_shape = .init(shape)
		
		super.init()
	}
	
	public convenience override init() {
		self.init(name: "")
	}
	
	public convenience init(name: String, takingFoodPack foodPackModel: FoodPack) {
		self.init(name: name, takingFoodPack: foodPackModel, shape: nil)
	}
	
	public convenience init(name: String, shape: Shapeish) {
		self.init(name: name, takingFoodPack: nil, shape: shape)
	}
	
	
	public let name: String
	
	private var _foodPackModel: FoodPack
	@SurrogateOfModel(\Elf._foodPackModel) public var foodPack: FoodPackish
	
	
	// MARK: RockPaperScissors.Playerish Conformance
	
	@Surrogate public var shape: RockPaperScissors.Shapeish
	
	
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
