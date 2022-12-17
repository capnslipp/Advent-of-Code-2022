//
//  HelloWorld.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol HelloWorldish : metacosmModelish
{
	var message: String { get }
}



// MARK: - Model

@objcMembers
public class HelloWorld : metacosmModel, HelloWorldish
{
	public override init() {
		super.init()
	}
	
	public init(message: String) {
		self.message = message
	}
	
	public var message: String = ""
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		guard message.count > 0 else { return true }
		return false
	}
}


// MARK: - Protocol Extensions

public extension HelloWorldish
{
	func print()
	{
		Swift.print(self.message)
	}
}



public extension HelloWorldish
{
	func surrogate() -> metacosmSurrogate & HelloWorldish {
		return surrogate() as! metacosmSurrogate & HelloWorldish
	}
}
