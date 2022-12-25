//
//  VersusOutcome.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol VersusOutcomeish : metacosmModelish
{
	var value: VersusOutcome.Value { get }
}



// MARK: - Model

@objcMembers
public class VersusOutcome : metacosmModel, VersusOutcomeish
{
	public override init() {}
	
	public init(value: Value) {
		self.value = value
	}
	public convenience init(_ value: Value) {
		self.init(value: value)
	}
	
	
	@objc public enum Value : UInt
	{
		case unset = 0
		
		case win
		static let won: Value = .win
		
		case lose
		static let lost: Value = .lost
		
		case draw
	}
	
	public var value: Value = .unset
	
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		guard self.value != .unset else { return true }
		return false
	}
}



// MARK: - Protocol Extensions

public extension VersusOutcomeish
{
	func surrogate() -> metacosmSurrogate & VersusOutcomeish {
		return surrogate() as! metacosmSurrogate & VersusOutcomeish
	}
}


extension VersusOutcome.Value : CustomStringConvertible
{
	public var description: String {
		switch self {
			case .unset: return "unset"
			case .win: return "win"
			case .lose: return "lose"
			case .draw: return "draw"
		}
	}
}


extension VersusOutcome
{
	/// An unfortante necessity.
	/// See: https://jayeshkawli.ghost.io/using-equatable/
	public override func isEqual(_ other: Any?) -> Bool {
		if let other = other as? VersusOutcomeish {
			return self.value == other.value
		}
		return false
	}
}
