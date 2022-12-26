import XCTest
@testable import RockPaperScissors
import With



final class RockPaperScissorsTests : XCTestCase
{
	func testShapeValueComparabilityAndEquality() throws
	{
		with(RockPaperScissors.Shape.Value.self) {
			XCTAssertTrue($0.rock == $0.rock)
			XCTAssertTrue($0.paper == $0.paper)
			XCTAssertTrue($0.scissors == $0.scissors)
			XCTAssertTrue($0.unset == $0.unset)
			
			XCTAssertTrue($0.unset <  $0.rock)
			XCTAssertTrue($0.unset <= $0.rock)
			XCTAssertTrue($0.unset <  $0.paper)
			XCTAssertTrue($0.unset <= $0.paper)
			XCTAssertTrue($0.unset <  $0.scissors)
			XCTAssertTrue($0.unset <= $0.scissors)
			
			XCTAssertTrue($0.rock >  $0.unset)
			XCTAssertTrue($0.rock >= $0.unset)
			XCTAssertTrue($0.paper >  $0.unset)
			XCTAssertTrue($0.paper >= $0.unset)
			XCTAssertTrue($0.scissors >  $0.unset)
			XCTAssertTrue($0.scissors >= $0.unset)
			
			XCTAssertTrue($0.rock <  $0.paper)
			XCTAssertTrue($0.rock <= $0.paper)
			XCTAssertTrue($0.paper <  $0.scissors)
			XCTAssertTrue($0.paper <= $0.scissors)
			XCTAssertTrue($0.scissors <  $0.rock)
			XCTAssertTrue($0.scissors <= $0.rock)
			
			XCTAssertTrue($0.rock >  $0.scissors)
			XCTAssertTrue($0.rock >= $0.scissors)
			XCTAssertTrue($0.paper >  $0.rock)
			XCTAssertTrue($0.paper >= $0.rock)
			XCTAssertTrue($0.scissors >  $0.paper)
			XCTAssertTrue($0.scissors >= $0.paper)
		}
	}
	
	func testShapeComparabilityAndEquality() throws
	{
		let shapeModels = (
			rock: Shape(.rock),
			paper: Shape(.paper),
			scissors: Shape(.scissors),
			unset: Shape()
		)
		let shapeSurrogates = (
			rock: Shape(.rock).surrogate() as Shapeish,
			paper: Shape(.paper).surrogate() as Shapeish,
			scissors: Shape(.scissors).surrogate() as Shapeish,
			unset: Shape().surrogate() as Shapeish
		)
		
		with(( shapeModels, shapeModels )) {
			XCTAssertTrue($0.0.rock == $0.1.rock)
			XCTAssertTrue($0.0.paper == $0.1.paper)
			XCTAssertTrue($0.0.scissors == $0.1.scissors)
			XCTAssertTrue($0.0.unset == $0.1.unset)
			
			XCTAssertTrue($0.0.unset <  $0.1.rock)
			XCTAssertTrue($0.0.unset <= $0.1.rock)
			XCTAssertTrue($0.0.unset <  $0.1.paper)
			XCTAssertTrue($0.0.unset <= $0.1.paper)
			XCTAssertTrue($0.0.unset <  $0.1.scissors)
			XCTAssertTrue($0.0.unset <= $0.1.scissors)
			
			XCTAssertTrue($0.0.rock >  $0.1.unset)
			XCTAssertTrue($0.0.rock >= $0.1.unset)
			XCTAssertTrue($0.0.paper >  $0.1.unset)
			XCTAssertTrue($0.0.paper >= $0.1.unset)
			XCTAssertTrue($0.0.scissors >  $0.1.unset)
			XCTAssertTrue($0.0.scissors >= $0.1.unset)
			
			XCTAssertTrue($0.0.rock <  $0.1.paper)
			XCTAssertTrue($0.0.rock <= $0.1.paper)
			XCTAssertTrue($0.0.paper <  $0.1.scissors)
			XCTAssertTrue($0.0.paper <= $0.1.scissors)
			XCTAssertTrue($0.0.scissors <  $0.1.rock)
			XCTAssertTrue($0.0.scissors <= $0.1.rock)
			
			XCTAssertTrue($0.0.rock >  $0.1.scissors)
			XCTAssertTrue($0.0.rock >= $0.1.scissors)
			XCTAssertTrue($0.0.paper >  $0.1.rock)
			XCTAssertTrue($0.0.paper >= $0.1.rock)
			XCTAssertTrue($0.0.scissors >  $0.1.paper)
			XCTAssertTrue($0.0.scissors >= $0.1.paper)
		}
		
		with(( shapeModels, shapeSurrogates )) {
			XCTAssertTrue($0.0.rock == $0.1.rock)
			XCTAssertTrue($0.0.paper == $0.1.paper)
			XCTAssertTrue($0.0.scissors == $0.1.scissors)
			XCTAssertTrue($0.0.unset == $0.1.unset)
			
			XCTAssertTrue($0.0.unset <  $0.1.rock)
			XCTAssertTrue($0.0.unset <= $0.1.rock)
			XCTAssertTrue($0.0.unset <  $0.1.paper)
			XCTAssertTrue($0.0.unset <= $0.1.paper)
			XCTAssertTrue($0.0.unset <  $0.1.scissors)
			XCTAssertTrue($0.0.unset <= $0.1.scissors)
			
			XCTAssertTrue($0.0.rock >  $0.1.unset)
			XCTAssertTrue($0.0.rock >= $0.1.unset)
			XCTAssertTrue($0.0.paper >  $0.1.unset)
			XCTAssertTrue($0.0.paper >= $0.1.unset)
			XCTAssertTrue($0.0.scissors >  $0.1.unset)
			XCTAssertTrue($0.0.scissors >= $0.1.unset)
			
			XCTAssertTrue($0.0.rock <  $0.1.paper)
			XCTAssertTrue($0.0.rock <= $0.1.paper)
			XCTAssertTrue($0.0.paper <  $0.1.scissors)
			XCTAssertTrue($0.0.paper <= $0.1.scissors)
			XCTAssertTrue($0.0.scissors <  $0.1.rock)
			XCTAssertTrue($0.0.scissors <= $0.1.rock)
			
			XCTAssertTrue($0.0.rock >  $0.1.scissors)
			XCTAssertTrue($0.0.rock >= $0.1.scissors)
			XCTAssertTrue($0.0.paper >  $0.1.rock)
			XCTAssertTrue($0.0.paper >= $0.1.rock)
			XCTAssertTrue($0.0.scissors >  $0.1.paper)
			XCTAssertTrue($0.0.scissors >= $0.1.paper)
		}
		
		with(( shapeSurrogates, shapeModels )) {
			XCTAssertTrue($0.0.rock == $0.1.rock)
			XCTAssertTrue($0.0.paper == $0.1.paper)
			XCTAssertTrue($0.0.scissors == $0.1.scissors)
			XCTAssertTrue($0.0.unset == $0.1.unset)
			
			XCTAssertTrue($0.0.unset <  $0.1.rock)
			XCTAssertTrue($0.0.unset <= $0.1.rock)
			XCTAssertTrue($0.0.unset <  $0.1.paper)
			XCTAssertTrue($0.0.unset <= $0.1.paper)
			XCTAssertTrue($0.0.unset <  $0.1.scissors)
			XCTAssertTrue($0.0.unset <= $0.1.scissors)
			
			XCTAssertTrue($0.0.rock >  $0.1.unset)
			XCTAssertTrue($0.0.rock >= $0.1.unset)
			XCTAssertTrue($0.0.paper >  $0.1.unset)
			XCTAssertTrue($0.0.paper >= $0.1.unset)
			XCTAssertTrue($0.0.scissors >  $0.1.unset)
			XCTAssertTrue($0.0.scissors >= $0.1.unset)
			
			XCTAssertTrue($0.0.rock <  $0.1.paper)
			XCTAssertTrue($0.0.rock <= $0.1.paper)
			XCTAssertTrue($0.0.paper <  $0.1.scissors)
			XCTAssertTrue($0.0.paper <= $0.1.scissors)
			XCTAssertTrue($0.0.scissors <  $0.1.rock)
			XCTAssertTrue($0.0.scissors <= $0.1.rock)
			
			XCTAssertTrue($0.0.rock >  $0.1.scissors)
			XCTAssertTrue($0.0.rock >= $0.1.scissors)
			XCTAssertTrue($0.0.paper >  $0.1.rock)
			XCTAssertTrue($0.0.paper >= $0.1.rock)
			XCTAssertTrue($0.0.scissors >  $0.1.paper)
			XCTAssertTrue($0.0.scissors >= $0.1.paper)
		}
		
		with(( shapeSurrogates, shapeSurrogates )) {
			XCTAssertTrue($0.0.rock == $0.1.rock)
			XCTAssertTrue($0.0.paper == $0.1.paper)
			XCTAssertTrue($0.0.scissors == $0.1.scissors)
			XCTAssertTrue($0.0.unset == $0.1.unset)
			
			XCTAssertTrue($0.0.unset <  $0.1.rock)
			XCTAssertTrue($0.0.unset <= $0.1.rock)
			XCTAssertTrue($0.0.unset <  $0.1.paper)
			XCTAssertTrue($0.0.unset <= $0.1.paper)
			XCTAssertTrue($0.0.unset <  $0.1.scissors)
			XCTAssertTrue($0.0.unset <= $0.1.scissors)
			
			XCTAssertTrue($0.0.rock >  $0.1.unset)
			XCTAssertTrue($0.0.rock >= $0.1.unset)
			XCTAssertTrue($0.0.paper >  $0.1.unset)
			XCTAssertTrue($0.0.paper >= $0.1.unset)
			XCTAssertTrue($0.0.scissors >  $0.1.unset)
			XCTAssertTrue($0.0.scissors >= $0.1.unset)
			
			XCTAssertTrue($0.0.rock <  $0.1.paper)
			XCTAssertTrue($0.0.rock <= $0.1.paper)
			XCTAssertTrue($0.0.paper <  $0.1.scissors)
			XCTAssertTrue($0.0.paper <= $0.1.scissors)
			XCTAssertTrue($0.0.scissors <  $0.1.rock)
			XCTAssertTrue($0.0.scissors <= $0.1.rock)
			
			XCTAssertTrue($0.0.rock >  $0.1.scissors)
			XCTAssertTrue($0.0.rock >= $0.1.scissors)
			XCTAssertTrue($0.0.paper >  $0.1.rock)
			XCTAssertTrue($0.0.paper >= $0.1.rock)
			XCTAssertTrue($0.0.scissors >  $0.1.paper)
			XCTAssertTrue($0.0.scissors >= $0.1.paper)
		}
	}
}
