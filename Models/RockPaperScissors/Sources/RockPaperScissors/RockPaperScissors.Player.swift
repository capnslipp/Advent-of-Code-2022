//
//  Player.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import AoC2022Support



// MARK: - Protocol

@objc
public protocol Playerish : metacosmModelish, Modelish
{
	var name: String { get }
	
	var shape: Shapeish { get }
}



// MARK: - Model

@objcMembers
public class Player : metacosmModel, Model, Playerish
{
	public typealias ProtocolType = Playerish
	
	
	public static let noPlayerSentinel: Playerish = Player(name: "«No Player»", shape: Shape(.unset)).surrogate()
	
	
	public init(name: String, shape: Shapeish)
	{
		self.name = name
		
		_shape = .init(shape)
	}
	
	
	public let name: String
	
	@SurrogateProperty public var shape: Shapeish
	
	
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


public func == (lhs: Playerish, rhs: Playerish) -> Bool {
	(lhs.name == rhs.name) &&
		(lhs.shape == rhs.shape)
}


public extension Playerish where Self == Playerish
{
	static var noPlayerSentinel: Playerish { Player.noPlayerSentinel }
}
