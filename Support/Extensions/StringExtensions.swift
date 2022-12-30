//
//  StringExtensions.swift
//  
//
//  Created by Cap'n Slipp on 12/24/22.
//

import Foundation



public extension StringProtocol
{
	/// Alias of `components(separatedBy:)`, so it's easy to find this when code completing for `split…`.
	func split(separator: CharacterSet) -> [String] {
		return self.components(separatedBy: separator)
	}
}
