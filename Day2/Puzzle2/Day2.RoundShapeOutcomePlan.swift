//
//  Day2.RoundShapeOutcomePlan.swift
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
public protocol RoundShapeOutcomePlanish : Modelish, metacosmModelish
{
	var opponentShapeValue: Shape.Value { get }
	
	var responseValue: VersusOutcome.Value { get }
}



// MARK: - Model

@objcMembers
public class RoundShapeOutcomePlan : metacosmModel, Model, RoundShapeOutcomePlanish
{
	public typealias ProtocolType = RoundShapeOutcomePlanish
	
	
	public var opponentShapeValue: Shape.Value
	
	public var responseValue: VersusOutcome.Value
	
	
	// MARK: Initialization/Deinitialization
	
	public init(opponentShapeValue: Shape.Value, responseValue: VersusOutcome.Value)
	{
		self.opponentShapeValue = opponentShapeValue
		self.responseValue = responseValue
	}
	public convenience init(opponent opponentShapeValue: Shape.Value, response responseValue: VersusOutcome.Value) {
		self.init(opponentShapeValue: opponentShapeValue, responseValue: responseValue)
	}
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		guard self.opponentShapeValue != Shape.Value.unset else { return true }
		guard self.responseValue != VersusOutcome.Value.unset else { return true }
		return false
	}
}


// MARK: - Protocol Extensions



public extension RoundShapeOutcomePlanish
{
	func surrogate() -> metacosmSurrogate & RoundShapeOutcomePlanish {
		return surrogate() as! metacosmSurrogate & RoundShapeOutcomePlanish
	}
}
