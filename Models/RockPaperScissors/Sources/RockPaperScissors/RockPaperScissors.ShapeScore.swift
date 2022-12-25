//
//  ShapeScore.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol ShapeScoreish : Scoreish
{
	var shape: Shapeish! { get }
	
	
	// Scoreish Adherance
	
	var value: Score.Value { get }
}



// MARK: - Model

@objcMembers
public class ShapeScore : metacosmModel, ShapeScoreish
{
	public init(shape: Shapeish) {
		self.shape = shape
	}
	
	func willDie() {
		// Hack to subvert bug in metacosm
		self.shape = nil
	}
	
	
	public private(set) var shape: Shapeish! {
		didSet { shape = shape?.surrogate() }
	}
	
	
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
