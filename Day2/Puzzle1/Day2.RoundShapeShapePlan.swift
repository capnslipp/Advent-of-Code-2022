//
//  Day2.RoundShapeShapePlan.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import AoC2022Support
import RockPaperScissors



// MARK: - Protocol

@objc
public protocol RoundShapeShapePlanish : Modelish, metacosmModelish
{
	var opponentShapeValue: Shape.Value { get }
	var responseShapeValue: Shape.Value { get }
}



// MARK: - Model

@objcMembers
public class RoundShapeShapePlan : metacosmModel, Model, RoundShapeShapePlanish
{
	public typealias ProtocolType = RoundShapeShapePlanish
	
	
	public var opponentShapeValue: Shape.Value
	
	public var responseShapeValue: Shape.Value
	
	
	// MARK: Initialization/Deinitialization
	
	public init(opponentShapeValue: Shape.Value, responseShapeValue: Shape.Value)
	{
		self.opponentShapeValue = opponentShapeValue
		self.responseShapeValue = responseShapeValue
	}
	public convenience init(opponent opponentShapeValue: Shape.Value, response responseShapeValue: Shape.Value) {
		self.init(opponentShapeValue: opponentShapeValue, responseShapeValue: responseShapeValue)
	}
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		guard self.opponentShapeValue != Shape.Value.unset else { return true }
		guard self.responseShapeValue != Shape.Value.unset else { return true }
		return false
	}
}


// MARK: - Protocol Extensions



public extension RoundShapeShapePlanish
{
	func surrogate() -> metacosmSurrogate & RoundShapeShapePlanish {
		return surrogate() as! metacosmSurrogate & RoundShapeShapePlanish
	}
}
