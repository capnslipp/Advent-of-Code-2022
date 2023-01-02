//
//  SurrogatePropertyWrapper.swift
//  
//
//  Created by Cap'n Slipp on 12/16/22.
//

import Foundation
import metacosm



public typealias SurrogateProperty = SurrogatePropertyWrapper
@propertyWrapper public struct SurrogatePropertyWrapper<ModelishT>
	 where ModelishT : metacosmModelish
{
	public let storage: ModelishT
	
	
	public init(_ storage: ModelishT) {
		self.init(wrappedValue: storage)
	}
	public init(wrappedValue: ModelishT) {
		self.storage = wrappedValue
	}
	
	public var wrappedValue: ModelishT {
		get { self.storage.surrogate() as! ModelishT }
	}
}
