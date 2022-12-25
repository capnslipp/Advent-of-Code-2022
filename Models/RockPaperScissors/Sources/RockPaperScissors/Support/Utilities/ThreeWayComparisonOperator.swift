//
//  ThreeWayComparisonOperator.swift
//  
//
//  Created by Cap'n Slipp on 12/25/22.
//

import Foundation



infix operator <=> : ComparisonPrecedence



@inlinable
public func <=> <T: Comparable> (lhs: T, rhs: T) -> ComparisonResult
{
	if lhs < rhs {
		return .orderedAscending
	} else if rhs < lhs {
		return .orderedDescending
	} else {
		return .orderedSame
	}
}

