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
	}
	
	
	let _updator: () -> Value
	var _isRunningUpdator: Bool = false
	
	
	private var _shapeModel = Shape()
	public var shape: Shapeish { _shapeModel.surrogate() }
	
	
	// MARK: Value
	
	public typealias Value = Shape.Value
	
	private var _staticValue: Value {
		get { _shapeModel.value }
		set { _shapeModel.value = newValue }
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
	
	public var score: ShapeScoreish { _shapeModel.score }
	
	
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
