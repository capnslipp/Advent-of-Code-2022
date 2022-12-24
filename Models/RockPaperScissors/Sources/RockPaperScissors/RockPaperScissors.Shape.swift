//
//  Shape.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol Shapeish : metacosmModelish
{
	var value: Shape.Value { get }
}



// MARK: - Model

@objcMembers
public class Shape : metacosmModel, Shapeish
{
	public override init() {}
	
	public init(value: Value) {
		self.value = value
	}
	public convenience init(value valueCharacterCode: Character) {
		self.init(value: Value(valueCharacterCode))
	}
	
	
	@objc public enum Value : UInt
	{
		case unset = 0
		
		case rock
		case paper
		case scissors
		
		public init(_ characterCode: Character)
		{
			switch characterCode {
				case "A", "X": self = .rock
				case "B", "Y": self = .paper
				case "C", "Z": self = .scissors
				
				default: self = .unset
			}
		}
	}
	
	public private(set) var value: Value = .unset
	
	
	
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

public extension Shapeish
{
	func surrogate() -> metacosmSurrogate & Shapeish {
		return surrogate() as! metacosmSurrogate & Shapeish
	}
}


extension Shape.Value : LosslessStringConvertible
{
	public init?(_ description: String) {
		switch description {
			case "unset": self = .unset
			case "rock": self = .rock
			case "paper": self = .paper
			case "scissors": self = .scissors
			default: return nil
		}
	}
	
	public var description: String {
		switch self {
			case .unset: return "unset"
			case .rock: return "rock"
			case .paper: return "paper"
			case .scissors: return "scissors"
		}
	}
}
