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
    
    var data: Data!
    var dataHandler: DataHandler!
    var schedules: [Schedule] = []
    
    override func setUp() {
        super.setUp()
        
        //self.data = Data()
        //self.dataHandler = DataHandler()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testOneRename()
    {
        // Grabs courses that have been marked by "heart" and uses them to 
        //I am testing with just one course therefore this is acceptible
        //let favoriteOfferings: [Offering] = data.offerings
        
        
        //let scheduler = Scheduler(offerings: favoriteOfferings)
        // Grabs courses that have been marked by "heart" and uses them to build schedule
        
        //let schedules = scheduler.getSchedules()
        

        XCTAssert(true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        self.dataHandler = DataHandler()
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
