//
//  VersusOutcomeScore.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol VersusOutcomeScoreish : Scoreish
{
	var versusOutcome: VersusOutcomeish! { get }
	
	
	// Scoreish Adherance
	
	var value: Score.Value { get }
}



// MARK: - Model

@objcMembers
public class VersusOutcomeScore : metacosmModel, VersusOutcomeScoreish
{
	public init(versusOutcome: VersusOutcomeish) {
		_versusOutcome = versusOutcome
	}
	
	func willDie() {
		// Hack to subvert bug in metacosm
		_versusOutcome = nil
	}
	
	
	private var _versusOutcome: VersusOutcomeish!
	public var versusOutcome: VersusOutcomeish! { _versusOutcome?.surrogate() }
	
	
	// MARK: Scoreish Adherance
	
	public typealias Value = Score.Value
	public var value: Value {
		switch self.versusOutcome?.value ?? .unset {
			case .win: return 6
			case .draw: return 3
			case .lose: return 0
			default: return 0
		}
	}
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		if self.versusOutcome?.isUnset ?? true { return true }
		return false
	}
}



// MARK: - Protocol Extensions

public extension VersusOutcomeScoreish
{
	func surrogate() -> metacosmSurrogate & VersusOutcomeScoreish {
		return surrogate() as! metacosmSurrogate & VersusOutcomeScoreish
	}
}
