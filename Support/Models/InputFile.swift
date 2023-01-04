//
//  InputFile.swift
//  
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import metacosm



// MARK: - Protocol

@objc
public protocol InputFileish : Modelish, metacosmModelish
{
	var nameValue: String { get }
	var bundleValue: Bundle { get }
	
	var urlValue: URL? { get }
	var contentsValue: String? { get }
}



// MARK: - Model

@objcMembers
public class InputFile : metacosmModel, Model, InputFileish
{
	public typealias ProtocolType = InputFileish
	
	
	public let nameValue: String
	
	public let bundleValue: Bundle
	
	public let urlValue: URL?
	
	private var _contentsValue: Optional<String?> = nil
	public var contentsValue: String? {
		guard let urlValue = self.urlValue else {
			return nil
		}
		if case .none = _contentsValue {
			_contentsValue = .some(
				try? String(contentsOf: urlValue)
			)
		}
		return _contentsValue!
	}
	
	
	// MARK: Initialization/Deinitialization
	
	public init(nameValue: String, bundleValue: Bundle? = nil)
	{
		self.nameValue = nameValue
		self.bundleValue = bundleValue ?? Bundle.main
		
		self.urlValue = self.bundleValue.url(forResource: nameValue, withExtension: "")
	}
	public convenience init(_ filenameValue: String, bundle bundleValue: Bundle? = nil) {
		self.init(nameValue: filenameValue, bundleValue: bundleValue)
	}
	
	
	// MARK: metacosmModelish Conformance
	
	public override var isInvalid: Bool {
		guard !self.isUnset else { return true }
		guard self.urlValue != nil else { return true }
		return false
	}
	
	public override var isUnset: Bool {
		return false
	}
}



// MARK: - Protocol Extensions


public extension InputFileish
{
	func surrogate() -> metacosmSurrogate & InputFileish {
		return surrogate() as! metacosmSurrogate & InputFileish
	}
}
