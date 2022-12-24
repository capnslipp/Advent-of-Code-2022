//
//  Round.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol Roundish : metacosmModelish
{
	var player1: Playerish { get }
	var player2: Playerish { get }
	
	var winnerPlayer: Playerish { get }
}



// MARK: - Model

@objcMembers
public class Round : metacosmModel, Roundish
{
	public init(player1: Playerish, player2: Playerish) {
		self.player1 = player1.surrogate()
		self.player2 = player2.surrogate()
	}
	
	
	public let player1: Playerish
	public let player2: Playerish
	
	public static let drawPlayerSentinel: Playerish = Player(name: "«Draw Sentinel»", shape: Shape(.unset)).surrogate()
	
	
	private var _currentWinnerPlayer: Playerish {
		let player1Shape = self.player1.shape
		let player2Shape = self.player2.shape
		
		if player1Shape > player2Shape {
			return self.player1
		} else if player1Shape < player2Shape {
			return self.player2
		} else {
			return Round.drawPlayerSentinel
		}
	}
	public lazy var winnerPlayer: Playerish = metacosmDelegatingSurrogate{ [weak self] in self?._currentWinnerPlayer.surrogate() } as! metacosmDelegatingSurrogate & Playerish
	
	
	
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

public extension Roundish
{
	func surrogate() -> metacosmSurrogate & Roundish {
		return surrogate() as! metacosmSurrogate & Roundish
	}
}
