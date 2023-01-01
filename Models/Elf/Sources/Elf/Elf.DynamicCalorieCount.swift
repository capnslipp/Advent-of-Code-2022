//
//  DynamicCalorieCount.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import AoC2022Support



// MARK: - Protocol

@objc
public protocol DynamicCalorieCountish : Modelish, CalorieCountish
{
}



// MARK: - Model

@objcMembers
public class DynamicCalorieCount : metacosmModel, Model, DynamicCalorieCountish
{
	public typealias ProtocolType = DynamicCalorieCountish
	
	
	public init(updator: @escaping ()->Int) {
		_updator = updator
	}
	
	
	let _updator: ()->Int
	var _isRunningUpdator: Bool = false
	
	
	let _calorieCountModel = CalorieCount()
	
	var _staticValue: Int {
		get { _calorieCountModel.value }
		set { _calorieCountModel.value = newValue }
	}
	
	public var value: Int {
		guard !_isRunningUpdator else { return _staticValue }
		_isRunningUpdator = true
		defer { _isRunningUpdator = false }
		
		let newValue = _updator()
		_staticValue = newValue
		return newValue
	}
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		guard _staticValue != CalorieCount.unsetValue else { return true }
		return false
	}
}


// MARK: - Protocol Extensions



public extension DynamicCalorieCountish
{
	func surrogate() -> metacosmSurrogate & DynamicCalorieCountish {
		return surrogate() as! metacosmSurrogate & DynamicCalorieCountish
	}
}
