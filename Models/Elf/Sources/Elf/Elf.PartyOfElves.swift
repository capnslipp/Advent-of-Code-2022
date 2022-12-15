//
//  PartyOfElves.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import NilCoalescingAssignmentOperators



// MARK: - Protocol

@objc
public protocol PartyOfElvesish : metacosmModelish
{
	var elves: [Elfish] { get }
	
	var elfWithMostCaloriesInFoodPack: Elfish? { get }
}



// MARK: - Model

@objcMembers
public class PartyOfElves : metacosmModel, PartyOfElvesish
{
	public override init() {
	}
	
	public init(elves: [Elfish]) {
		_elves = elves
		defer { recalcElfWithMostCaloriesInFoodPack() }
		
		super.init()
	}
	
	
	public var _elves: [Elfish] = []
	public var elves: [Elfish] { _elves.map{ $0.surrogate() } }
	
	public var isEmpty: Bool {
		_elves.isEmpty
	}
	
	public func add(elf: Elfish) {
		_elves.append(elf)
		recalcElfWithMostCaloriesInFoodPack()
	}
	
	public func add(elves: [Elfish]) {
		_elves.append(contentsOf: elves)
		recalcElfWithMostCaloriesInFoodPack()
	}
	
	
	private typealias ElfCalorieCountPair = ( elf: Elfish, calorieCount: CalorieCountish )
	private static let _noElfCalorieCountSentinel: ElfCalorieCountPair = ( Elf().surrogate(), CalorieCount(value: CalorieCount.minimumValue).surrogate() )
	
	private var _elfWithMostCaloriesInFoodPack: ElfCalorieCountPair? = nil
	private func recalcElfWithMostCaloriesInFoodPack() {
		_elfWithMostCaloriesInFoodPack = nil
	}
	public var elfWithMostCaloriesInFoodPack: Elfish? {
		_elfWithMostCaloriesInFoodPack ??= {
			var highest = PartyOfElves._noElfCalorieCountSentinel
			highest = _elves.reduce(into: highest) { highest, anElf in
				if anElf.foodPack.totalCalorieCount > highest.calorieCount {
					highest = ( anElf, anElf.foodPack.totalCalorieCount )
				}
			}
			guard highest.elf !== PartyOfElves._noElfCalorieCountSentinel.elf else { return nil }
			return highest
		}()
		
		return _elfWithMostCaloriesInFoodPack?.elf
	}
	
	
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



public extension PartyOfElvesish
{
	func surrogate() -> metacosmSurrogate & PartyOfElvesish {
		return surrogate() as! metacosmSurrogate & PartyOfElvesish
	}
}
