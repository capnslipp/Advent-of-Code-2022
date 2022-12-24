//
//  RecordCountLimit.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol RecordCountLimitish : metacosmModelish
{
	var value: UInt { get }
}



// MARK: - Model

@objcMembers
public class RecordCountLimit : metacosmModel, RecordCountLimitish
{
	public override init() {
		self.value = RecordCountLimit.defaultValue
	}
	
	public init(value: UInt) {
		self.value = value
	}
	
	
	static let minimumValue: UInt = 1
	static let defaultValue: UInt = RecordCountLimit.minimumValue
	
	public var value: UInt = RecordCountLimit.defaultValue {
		didSet {
			self.value = max(RecordCountLimit.minimumValue, self.value)
		}
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



public extension RecordCountLimitish
{
	func surrogate() -> metacosmSurrogate & RecordCountLimitish {
		return surrogate() as! metacosmSurrogate & RecordCountLimitish
	}
}


func == (recordLimitA: RecordCountLimitish, recordLimitB: RecordCountLimitish) -> Bool {
	return (recordLimitA.value == recordLimitB.value)
}
func < (recordLimitA: RecordCountLimitish, recordLimitB: RecordCountLimitish) -> Bool {
	return (recordLimitA.value < recordLimitB.value)
}
func <= (recordLimitA: RecordCountLimitish, recordLimitB: RecordCountLimitish) -> Bool {
	return (recordLimitA.value <= recordLimitB.value)
}
func > (recordLimitA: RecordCountLimitish, recordLimitB: RecordCountLimitish) -> Bool {
	return (recordLimitA.value > recordLimitB.value)
}
func >= (recordLimitA: RecordCountLimitish, recordLimitB: RecordCountLimitish) -> Bool {
	return (recordLimitA.value >= recordLimitB.value)
}

