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
	
	var score: ShapeScoreish { get }
}



// MARK: - Model

@objcMembers
public class Shape : metacosmModel, Shapeish
{
	public override convenience init() {
		self.init(value: .unset)
	}
	
	public init(value: Value) {
		self.value = value
		
		super.init()
		
		_score = .init(model: ShapeScore(shape: self.surrogate()))
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
		
		case rock = 1
		case paper = 2
		case scissors = 3
		
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
	
	public var value: Value = .unset
	
	
	// MARK: Score
	
	@ModelSurrogate<ShapeScore, ShapeScoreish> public var score: ShapeScoreish
	
	
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


extension Shape.Value : CustomStringConvertible
{
	public var description: String {
		switch self {
			case .unset: return "unset"
			case .rock: return "🪨 rock"
			case .paper: return "📜 paper"
			case .scissors: return "✂️ scissors"
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


public func + (lhs: Shape.Value, rhs: Int) -> Shape.Value {
	guard lhs != .unset else {
		return .unset
	}
	guard rhs >= 0 else {
		return lhs - (-rhs)
	}
	var rawValue = Int(lhs.rawValue) + rhs
	rawValue = (rawValue - 1) % 3 + 1 // modulus to normal 1-3 range, for finite numbers ≥1
	return Shape.Value(rawValue: UInt(rawValue))!
}

public func - (lhs: Shape.Value, rhs: Int) -> Shape.Value {
	guard lhs != .unset else {
		return .unset
	}
	guard rhs >= 0 else {
		return lhs + (-rhs)
	}
	var rawValue = Int(lhs.rawValue) - rhs
	rawValue = ((rawValue - 1) % 3 + 3) % 3 + 1 // modulus to normal 1-3 range, for all finite numbers
	return Shape.Value(rawValue: UInt(rawValue))!
}
