//
//  SurrogatePropertyWrapper.swift
//  
//
//  Created by Cap'n Slipp on 12/16/22.
//

import Foundation
import metacosm



public typealias ModelSurrogate = ModelSurrogateWrapper
@propertyWrapper public struct ModelSurrogateWrapper<ModelT, ModelishT>
	 where ModelT : metacosmModel, ModelishT : metacosmModelish
{
	public let model: ModelT
	
	
	public init(_ model: ModelT) {
		self.init(model: model)
	}
	public init(model: ModelT) {
		self.model = model
	}
	
	public var wrappedValue: ModelishT {
		get { self.model.surrogate() as! ModelishT }
	}
}
