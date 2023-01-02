//
//  SurrogateArrayPropertyWrapper.swift
//  
//
//  Created by Cap'n Slipp on 12/16/22.
//

import Foundation
import metacosm



public typealias SurrogateArrayProperty = SurrogateArrayPropertyWrapper
@propertyWrapper public struct SurrogateArrayPropertyWrapper<ModelishT> where ModelishT : metacosmModelish
{
	public var storage: [ModelishT]
	
	
	public init(_ storage: [ModelishT]) {
		self.init(wrappedValue: storage)
	}
	public init(wrappedValue: [ModelishT]) {
		self.storage = wrappedValue
	}
	
	public var wrappedValue: [ModelishT] {
		get { self.storage.map{ $0.surrogate() as! ModelishT } }
	}
}
