//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Scott Ashmore on 03/02/2016.
//  Copyright © 2016 Scott Ashmore. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
  
  // MARK: FoodTracker Tests
  
  // Tests to confirm that the Meal Initializer returns nil when no name or a negative rating is provided.
  func testMealInitialization() {
    
    // success case.
    let potentialItem = Meal(name: "Newest Meal", photo: nil, rating: 5)
    XCTAssertNotNil(potentialItem)
    
    // failure cases.
    let noName = Meal(name: "", photo: nil, rating: 0)
    XCTAssertNil(noName, "Empty name is invalid")
    
    let badRating = Meal(name: "Really bad rating", photo: nil, rating: -1)
    XCTAssertNil(badRating, "Negative ratings are invalid, be positive")
    
  }
    
}
