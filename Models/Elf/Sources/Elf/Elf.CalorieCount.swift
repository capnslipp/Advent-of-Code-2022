//
//  CalorieCount.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import AoC2022Support



// MARK: - Protocol

@objc
public protocol CalorieCountish : Modelish, metacosmModelish
{
	var value: Int { get }
}



// MARK: - Model

@objcMembers
public class CalorieCount : metacosmModel, Model, CalorieCountish
{
	public typealias ProtocolType = CalorieCountish
	
	
	public override init() {}
	
	public init(value: Int) {
		self.value = value
	}
	
	
	static let unsetValue = -1
	static let minimumValue = 0
	
	public var value: Int = CalorieCount.unsetValue {
		didSet {
			self.value = max(CalorieCount.minimumValue, self.value)
		}
	}
	
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		guard self.value != CalorieCount.unsetValue else { return true }
		return false
	}
}


// MARK: - Protocol Extensions



public extension CalorieCountish
{
	func surrogate() -> metacosmSurrogate & CalorieCountish {
		return surrogate() as! metacosmSurrogate & CalorieCountish
	}
}


func == (calorieCountA: CalorieCountish, calorieCountB: CalorieCountish) -> Bool {
	return (calorieCountA.value == calorieCountB.value)
}
func < (calorieCountA: CalorieCountish, calorieCountB: CalorieCountish) -> Bool {
	return (calorieCountA.value < calorieCountB.value)
}
func <= (calorieCountA: CalorieCountish, calorieCountB: CalorieCountish) -> Bool {
	return (calorieCountA.value <= calorieCountB.value)
}
func > (calorieCountA: CalorieCountish, calorieCountB: CalorieCountish) -> Bool {
	return (calorieCountA.value > calorieCountB.value)
}
func >= (calorieCountA: CalorieCountish, calorieCountB: CalorieCountish) -> Bool {
	return (calorieCountA.value >= calorieCountB.value)
}

