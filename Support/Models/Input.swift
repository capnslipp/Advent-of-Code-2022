//
//  Input.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol Inputish : Modelish, metacosmModelish
{
	var modeValue: Input.ModeValue { get }
	
	var file: InputFileish { get }
	
	var linesValue: [String] { get }
}



// MARK: - Model

@objcMembers
public class Input : metacosmModel, Model, Inputish
{
	public typealias ProtocolType = Inputish
	
	
	@objc public enum ModeValue : Int {
		case example
		case real
	}
	public let modeValue: ModeValue
	
	
	@SurrogateProperty public var file: InputFileish
	
	
	private lazy var _linesValue: [String] = (self.file.contentsValue ?? "").components(separatedBy: .newlines)
	public var linesValue: [String] { _linesValue }
	
	
	// MARK: Initialization/Deinitialization
	
	public init(modeValue: ModeValue)
	{
		self.modeValue = modeValue
		
		_file = .init({
			switch modeValue {
				case .example: return InputFile("input.example")
				case .real: return InputFile("input")
			}
		}())
	}
	public convenience init (mode modeValue: ModeValue) {
		self.init(modeValue: modeValue)
	}
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		guard !self.file.isInvalid else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		return false
	}
}


// MARK: - Protocol Extensions



public extension Inputish
{
	func surrogate() -> metacosmSurrogate & Inputish {
		return surrogate() as! metacosmSurrogate & Inputish
	}
}
