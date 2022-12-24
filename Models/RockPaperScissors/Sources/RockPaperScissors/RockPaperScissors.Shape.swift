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
	public convenience init(_ value: Value) {
		self.init(value: value)
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


extension Shape.Value : Comparable
{
	public static func < (lhs: Shape.Value, rhs: Shape.Value) -> Bool
	{
		if lhs == rhs { return false }
		else if lhs == .unset { return true }
		else if rhs == .unset { return false }
		else {
			switch lhs {
				case .rock: return (rhs == .paper)
				case .paper: return (rhs == .scissors)
				case .scissors: return (rhs == .rock)
				
				default: fatalError("Bad implementation doesn't handle all cases in switch or preceding `if`.")
			}
		}
	}
}


extension Shape
{
	/// An unfortante necessity.
	/// See: https://jayeshkawli.ghost.io/using-equatable/
	public override func isEqual(_ other: Any?) -> Bool {
		if let other = other as? Shapeish {
			return self.value == other.value
		}
		return false
	}
	
	/// I don't think this will actually ever get called (preferring `isEqual(_:)` above), but it compiles so lets leave them in for the time being.
	public static func == (lhs: Shape, rhs: Shapeish) -> Bool { lhs.value == rhs.value }
	/// I don't think this will actually ever get called (preferring `isEqual(_:)` above), but it compiles so lets leave them in for the time being.
	public static func == (lhs: Shape, rhs: Shape) -> Bool { lhs.value == rhs.value }
}

extension Shapeish where Self == Shape
{
	/// I don't think this will actually ever get called (preferring `isEqual(_:)` above), but it compiles so lets leave them in for the time being.
	public static func == (lhs: Shapeish, rhs: Shapeish) -> Bool { lhs.value == rhs.value }
}

extension Shapeish where Self : metacosmSurrogate
{
	/// I don't think this will actually ever get called (preferring `isEqual(_:)` above), but it compiles so lets leave them in for the time being.
	public static func == (lhs: metacosmSurrogate & Shapeish, rhs: Shapeish) -> Bool { lhs.value == rhs.value }
}

public func != (lhs: Shapeish, rhs: Shapeish) -> Bool { lhs.value != rhs.value }
public func <  (lhs: Shapeish, rhs: Shapeish) -> Bool { lhs.value < rhs.value }
public func <= (lhs: Shapeish, rhs: Shapeish) -> Bool { lhs.value <= rhs.value }
public func >  (lhs: Shapeish, rhs: Shapeish) -> Bool { lhs.value > rhs.value }
public func >= (lhs: Shapeish, rhs: Shapeish) -> Bool { lhs.value >= rhs.value }
