//
//  ShapeScore.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import AoC2022Support



// MARK: - Protocol

@objc
public protocol ShapeScoreish : Scoreish, Modelish
{
	var shape: Shapeish! { get }
	
	
	// Scoreish Adherance
	
	var value: Score.Value { get }
}



// MARK: - Model

@objcMembers
public class ShapeScore : metacosmModel, Model, ShapeScoreish
{
	public typealias ProtocolType = ShapeScoreish
	
	
	public init(shape: Shapeish) {
		_shape = shape
	}
	
	func willDie() {
		// Hack to subvert bug in metacosm
		_shape = nil
	}
	
	private var _shape: Shapeish!
	public var shape: Shapeish! { _shape?.surrogate() }
	
	
	// MARK: Scoreish Adherance
	
	public typealias Value = Score.Value
	public var value: Value {
		switch self.shape?.value ?? .unset {
			case .rock: return 1
			case .paper: return 2
			case .scissors: return 3
			default: return 0
		}
	}
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		if self.shape?.isUnset ?? true { return true }
		return false
	}
}



// MARK: - Protocol Extensions

public extension ShapeScoreish
{
	func surrogate() -> metacosmSurrogate & ShapeScoreish {
		return surrogate() as! metacosmSurrogate & ShapeScoreish
	}
}
