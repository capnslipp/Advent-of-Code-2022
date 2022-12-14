//
//  main.swift
//  Day1-Puzzle1
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
protocol HelloWorldish : metacosmModelish
{
	var message: String { get }
}



// MARK: - Model

@objcMembers
class HelloWorld : metacosmModel, HelloWorldish
{
	override init() {
		super.init()
	}
	
	init(message: String) {
		self.message = message
	}
	
	var message: String = ""
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		guard message.count > 0 else { return false }
		return true
	}
}


// MARK: - Protocol Extensions

extension HelloWorldish
{
	func print()
	{
		Swift.print(self.message)
	}
}



extension HelloWorldish
{
	func surrogate() -> metacosmSurrogate & HelloWorldish {
		return surrogate() as! metacosmSurrogate & HelloWorldish
	}
}




// MARK: - Top-Level “Main”

let helloWorld: HelloWorldish = HelloWorld(message: "Hello, World!").surrogate()
helloWorld.print()
