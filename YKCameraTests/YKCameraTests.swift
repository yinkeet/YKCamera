//
//  YKCameraTests.swift
//  YKCameraTests
//
//  Created by Yin Keet on 26/08/2018.
//  Copyright © 2018 Lancet. All rights reserved.
//

//import XCTest
//@testable import YKCamera
//
//class YKCameraTests: XCTestCase {
//
//    override func setUp() {
//        super.setUp()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}

import Quick
import Nimble
import YKCamera

class YKCameraTests: QuickSpec {
    override func spec() {
        describe("YKCamera") {
            it("works") {
                let photoCamera = YKPhotoCamera()
                let result = photoCamera.test()
                expect(result).to(beTrue())
            }
        }
    }
}
