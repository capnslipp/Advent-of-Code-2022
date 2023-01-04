//
//  Output.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol Outputish : Modelish, metacosmModelish
{
	var linesValue: [String] { get }
	var isBlank: Bool { get }
}



// MARK: - Model

@objcMembers
public class Output : metacosmModel, Model, Outputish
{
	public typealias ProtocolType = Outputish
	
	
	public private(set) var linesValue: [String] = []
	
	public var isBlank: Bool { self.linesValue.isEmpty }
	
	public func addLine(value: String) {
		self.linesValue.append(value)
	}
	
	public func clear() {
		self.linesValue.removeAll(keepingCapacity: true)
	}
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		guard !self.isBlank else { return true }
		return false
	}
}


// MARK: - Protocol Extensions



public extension Outputish
{
	func surrogate() -> metacosmSurrogate & Outputish {
		return surrogate() as! metacosmSurrogate & Outputish
	}
	
	
	func print(lineSeparator: String = "\n")
	{
		Swift.print(
			self.linesValue.joined(separator: lineSeparator)
		)
	}
}
