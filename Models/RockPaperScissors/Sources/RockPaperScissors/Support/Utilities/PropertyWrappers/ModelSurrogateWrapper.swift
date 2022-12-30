//
//  SurrogatePropertyWrapper.swift
//  
//
//  Created by Cap'n Slipp on 12/16/22.
//

import Foundation
import metacosm



public typealias ModelSurrogate = ModelSurrogateWrapper
@propertyWrapper public enum ModelSurrogateWrapper<ModelT, ModelishT>
	 where ModelT : metacosmModel, ModelishT : metacosmModelish
{
	case uninitialized // Hack to side-step `error: 'self' used before 'super.init' call` woes when trying to initialize with a closure.
	case model(ModelT)
	case getClosure(() -> ModelT)
	
	var model: ModelT {
		get {
			switch self {
				case .uninitialized: fatalError("ModelSurrogateWrapper must be initialized before use.")
				case .model(let model): return model
				case .getClosure(let closure): return closure()
			}
		}
	}
	
	
	public init() {
		self = .uninitialized
	}
	
	public init(_ model: ModelT) {
		self.init(model: model)
	}
	public init(model: ModelT) {
		self = .model(model)
	}
	
	public init(get getClosure: @autoclosure @escaping () -> ModelT) {
		self.init(getClosure: getClosure)
	}
	public init(getClosure: @escaping () -> ModelT) {
		self = .getClosure(getClosure)
	}
	
	
	public var wrappedValue: ModelishT {
		get { self.model.surrogate() as! ModelishT }
	}
}
