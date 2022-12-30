//
//  DynamicShape.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol DynamicShapeish : Shapeish
{
	var shape: Shapeish { get }
	
	var value: DynamicShape.Value { get }
	
	var score: ShapeScoreish { get }
}



// MARK: - Model

@objcMembers
public class DynamicShape : metacosmModel, DynamicShapeish
{
	public init(updator: @escaping () -> Value) {
		_updator = updator
		
		_shape = .init(model: Shape())
	}
	
	
	let _updator: () -> Value
	var _isRunningUpdator: Bool = false
	
	
	@ModelSurrogate<Shape, Shapeish> public var shape: Shapeish
	
	
	// MARK: Value
	
	public typealias Value = Shape.Value
	
	private var _staticValue: Value {
		get { _shape.model.value }
		set { _shape.model.value = newValue }
	}
	
	public var value: Value {
		guard !_isRunningUpdator else { return _staticValue }
		_isRunningUpdator = true
		defer { _isRunningUpdator = false }
		
		let newValue = _updator()
		_staticValue = newValue
		return newValue
	}
	
	
	// MARK: Score
	
	public var score: ShapeScoreish { _shape.model.score }
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		guard self.value != Value.unset else { return true }
		return false
	}
}



// MARK: - Protocol Extensions

public extension DynamicShapeish
{
	func surrogate() -> metacosmSurrogate & DynamicShapeish {
		return surrogate() as! metacosmSurrogate & DynamicShapeish
	}
}
