//
//  LazyPropertyWrapper.swift
//  
//
//  Created by Cap'n Slipp on 12/16/22.
//

import Foundation



@propertyWrapper
enum Lazy<Value>
{
	case uninitialized(() -> Value)
	case initialized(Value)
	
	
	init(wrappedValue: @autoclosure @escaping () -> Value) {
		self = .uninitialized(wrappedValue)
	}
	
	var wrappedValue: Value {
		mutating get {
			switch self {
				case .uninitialized(let initializer):
					let value = initializer()
					self = .initialized(value)
					return value
				case .initialized(let value):
					return value
			}
		}
		set {
			self = .initialized(newValue)
		}
	}
	
	
	public var projectedValue: Self { self }
	
	public var storage: Value? {
		switch self {
			case .uninitialized(_):
				return nil
			case .initialized(let value):
				return value
		}
	}
}
