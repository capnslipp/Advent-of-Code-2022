//
//  VersusOutcome.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import AoC2022Support



// MARK: - Protocol

@objc
public protocol VersusOutcomeish : metacosmModelish, Modelish
{
	var value: VersusOutcome.Value { get }
	
	var score: VersusOutcomeScoreish { get }
}



// MARK: - Model

@objcMembers
public class VersusOutcome : metacosmModel, Model, VersusOutcomeish
{
	public typealias ProtocolType = VersusOutcomeish
	
	
	public override convenience init() {
		self.init(value: .unset)
	}
	
	public init(value: Value)
	{
		self.value = value
		
		defer { _score.owner = self }
		
		super.init()
	}
	public convenience init(_ value: Value) {
		self.init(value: value)
	}
	
	public convenience init(value valueCharacterCode: Character) {
		self.init(value: Value(valueCharacterCode))
	}
	
	
	@objc public enum Value : UInt
	{
		case unset = 0
		
		case win
		static let won: Value = .win
		
		case lose
		static let lost: Value = .lost
		
		case draw
		
		public init(_ characterCode: Character)
		{
			switch characterCode {
				case "X": self = .lose
				case "Y": self = .draw
				case "Z": self = .win
				
				default: self = .unset
			}
		}
	}
	
	public var value: Value = .unset
	
	
	// MARK: Score
	
	private lazy var _scoreModel: VersusOutcomeScore = VersusOutcomeScore(versusOutcome: self.surrogate())
	@ModelProperty(\VersusOutcome._scoreModel) public var score: VersusOutcomeScoreish
	
	
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
