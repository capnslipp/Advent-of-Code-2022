//
//  Puzzle.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol Puzzleish : Modelish, metacosmModelish
{
	var input: Inputish { get }
	
	var answerValue: Int { get }
	
	var output: Outputish { get }
	
	var hasRun: Bool { get }
}



// MARK: - Model

/// Template for `Puzzleish`-conforming models— serves only as example code; like an abstract base class, not `init`-able.
@objcMembers
public class Puzzle : metacosmModel, Model, Puzzleish
{
	public typealias ProtocolType = Puzzleish
	
	
	@SurrogateProperty public var input: Inputish
	
	
	public static let invalidAnswerValue = -1
	public var answerValue: Int { Self.invalidAnswerValue }
	
	
	private var _outputModel = Output()
	@ModelProperty(\Puzzle._outputModel) public var output: Outputish
	
	
	public private(set) var hasRun: Bool = false
	
	
	// MARK: Mutating Methods
	
	public func run()
	{
		let out = _outputModel
		if !out.isBlank {
			out.clear()
		}
		defer { self.hasRun = true }
		
		// Add lines to output with `out.addLine(value: …)` here.
		out.addLine(value: "")
	}
	
	
	// MARK: Initialization/Deinitialization
	
	public init(input: Inputish)
	{
		fatalError("Example code only; not init-able.");
		
		_input = .init(input)
		
		defer { _output.owner = self }
		
		super.init()
	}
	
	public convenience init(inputMode: Input.ModeValue)
	{
		self.init(input: Input(mode: inputMode))
	}
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		guard !self.input.isInvalid else { return true }
		guard !self.output.isInvalid else { return true }
		guard self.answerValue != Self.invalidAnswerValue else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		guard self.hasRun else { return false }
		guard !self.input.isUnset else { return true }
		guard !self.output.isUnset else { return true }
		return false
	}
}


// MARK: - Protocol Extensions



public extension Puzzleish
{
	func surrogate() -> metacosmSurrogate & Puzzleish {
		return surrogate() as! metacosmSurrogate & Puzzleish
	}
}
