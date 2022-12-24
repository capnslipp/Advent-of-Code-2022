//
//  Player.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol Playerish : metacosmModelish
{
	var name: String { get }
	
	var shape: Shapeish { get }
}



// MARK: - Model

@objcMembers
public class Player : metacosmModel, Playerish
{
	public init(name: String, shape: Shapeish) {
		self.name = name
		self.shape = shape.surrogate()
	}
	
	
	public let name: String
	
	public let shape: Shapeish
	
	
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

public extension Playerish
{
	func surrogate() -> metacosmSurrogate & Playerish {
		return surrogate() as! metacosmSurrogate & Playerish
	}
}
