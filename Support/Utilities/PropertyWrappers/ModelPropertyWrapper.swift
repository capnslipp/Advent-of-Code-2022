//
//  SurrogateOfModel.swift
//  
//
//  Created by Cap'n Slipp on 12/16/22.
//

import Foundation
import metacosm



public typealias ModelProperty = ModelPropertyWrapper
@propertyWrapper public struct ModelPropertyWrapper<OwnerT, ModelishT>
	 where OwnerT : AnyObject, ModelishT : metacosmModelish
{
	public unowned(unsafe) var owner: OwnerT!
	
	let getClosure: (OwnerT) -> ModelishT
	
	var modelish: ModelishT {
		guard let owner = self.owner else {
			fatalError("\(Self.self)'s `owner` must be set before use, which is commonly performed in the owning class's (\(OwnerT.self)'s) init.")
		}
		return getClosure(owner)
	}
	
	
	public init(_ getKeypath: KeyPath<OwnerT, ModelishT>) {
		self.init{ $0[keyPath: getKeypath] }
	}
	public init<ModelT : Model>(_ getKeypath: KeyPath<OwnerT, ModelT>) where ModelT.ProtocolType == ModelishT {
		self.init{ $0[keyPath: getKeypath] as! ModelishT }
	}
	public init(_ getClosure: @escaping (OwnerT) -> ModelishT) {
		self.getClosure = getClosure
	}
	
	
	public var wrappedValue: ModelishT {
		get { self.modelish.surrogate() as! ModelishT }
	}
}
