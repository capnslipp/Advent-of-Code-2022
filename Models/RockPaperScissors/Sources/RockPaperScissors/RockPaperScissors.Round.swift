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
	var player1Outcome: VersusOutcomeish { get }
	
	var player2: Playerish { get }
	var player2Outcome: VersusOutcomeish { get }
	
	var winnerPlayer: Playerish { get }
	
	var isReady: Bool { get }
	var isPlayed: Bool { get }
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
	
	private var _player1OutcomeModel: VersusOutcome = VersusOutcome()
	public var player1Outcome: VersusOutcomeish { _player1OutcomeModel.surrogate() }
	
	public let player2: Playerish
	
	private var _player2OutcomeModel: VersusOutcome = VersusOutcome()
	public var player2Outcome: VersusOutcomeish { _player2OutcomeModel.surrogate() }
	
	public static let drawPlayerSentinel: Playerish = Player(name: "«Draw Player»", shape: Shape(.unset)).surrogate()
	
	
	// MARK: [current]WinnerPlayer
	
	private enum WinnerId { case player1, player2, draw }
	private var _winnerId: WinnerId?
	
	private var _currentWinnerPlayer: Playerish = .noPlayerSentinel
	
	public lazy var winnerPlayer: Playerish = metacosmDelegatingSurrogate{ [weak self] in
		self?._currentWinnerPlayer.surrogate()
	} as! metacosmDelegatingSurrogate & Playerish
	
	
	// MARK: `play()`/`reset()` and Winner Calculation
	
	private enum State { case unstarted, played, resetted }
	private var _state: State = .unstarted
	public var isReady: Bool { _state == .unstarted || _state == .resetted }
	public var isPlayed: Bool { _state == .played }
	
	public func start() { play() }
	public func play()
	{
		guard _state != .played else {
			fatalError("Round has already been `play()`ed— `reset()` the round first before `play()`ing again.")
		}
		calculateWinner()
	}
	
	private func calculateWinner()
	{
		_winnerId = { switch self.player1.shape.value <=> self.player2.shape.value {
			case .orderedDescending: return .player1
			case .orderedAscending: return .player2
			case .orderedSame: return .draw
		}}()
		_currentWinnerPlayer = { switch _winnerId! {
			case .player1: return player1
			case .player2: return player2
			case .draw: return Self.drawPlayerSentinel
		}}()
		_player1OutcomeModel.value = { switch _winnerId! {
			case .player1: return .won
			case .player2: return .lost
			case .draw: return .draw
		}}()
		_player2OutcomeModel.value = { switch _winnerId! {
			case .player1: return .lost
			case .player2: return .won
			case .draw: return .draw
		}}()
	}
	
	public func reset()
	{
		resetWinner()
	}
	
	private func resetWinner()
	{
		_winnerId = nil
		_currentWinnerPlayer = .noPlayerSentinel
		_player1OutcomeModel.value = .unset
		_player2OutcomeModel.value = .unset
	}
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		return false
	}
	
	public override var isUnset: Bool {
		if self.isReady { return true }
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


public extension Roundish where Self == Roundish
{
	static var noPlayerSentinel: Playerish { Player.noPlayerSentinel }
	static var drawPlayerSentinel: Playerish { Round.drawPlayerSentinel }
}
