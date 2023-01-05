//
//  Day3.Puzzle1.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm
import AoC2022Support



// MARK: - Protocol

@objc
public protocol Puzzle1ish : Modelish, Puzzleish
{
}



// MARK: - Model

@objcMembers
public class Puzzle1 : metacosmModel, Model, Puzzle1ish
{
	public typealias ProtocolType = Puzzle1ish
	
	
	@SurrogateProperty public var input: Inputish
	
	
	public static let invalidAnswerValue = Puzzle.invalidAnswerValue
	public var answerValue: Int { Self.invalidAnswerValue }
	
	
	private var _outputModel = Output()
	@ModelProperty(\Puzzle1._outputModel) public var output: Outputish
	
	
	public private(set) var hasRun: Bool = false
	
	
	// MARK: Mutating Methods
	
	public func run()
	{
		defer { self.hasRun = true }
		
		let out = _outputModel
		if !out.isBlank {
			out.clear()
		}
		let print = { string in out.addLine(value: string) }
	}
	
	
	// MARK: Initialization/Deinitialization
	
	public init(input: Inputish)
	{
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



public extension Puzzle1ish
{
	func surrogate() -> metacosmSurrogate & Puzzle1ish {
		return surrogate() as! metacosmSurrogate & Puzzle1ish
	}
}
