//
//  ScheduleBuilderTests.swift
//  ScheduleBuilderTests
//
//  Created by Sasha Ivanov on 2015-10-30.
//  Copyright © 2015 Alexander Ivanov. All rights reserved.
//

import XCTest
@testable import ScheduleBuilder

class ScheduleBuilderTests: XCTestCase {
    var dh: DataHandler!
    
    var sched: [Schedule] = []
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        self.dh = DataHandler()
        
        var a = ScheduleBuilder()
        
        a.getValidSchedules(self.dh.courses)
        
        let gg = a.validSchedules
        XCTAssert(true)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
