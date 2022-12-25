//
//  Score.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol Scoreish : metacosmModelish
{
	var value: Score.Value { get }
}



// MARK: - Model

@objcMembers
public class Score : metacosmModel, Scoreish
{
	public override init() {}
	
	public init(value: Value) {
		self.value = value
	}
	
	
	public typealias Value = UInt
	public var value: Value = Score.zeroValue
	
	public static let zeroValue: Value = 0
	
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		return false
	}
}



// MARK: - Protocol Extensions

public extension Scoreish
{
	func surrogate() -> metacosmSurrogate & Scoreish {
		return surrogate() as! metacosmSurrogate & Scoreish
	}
}
