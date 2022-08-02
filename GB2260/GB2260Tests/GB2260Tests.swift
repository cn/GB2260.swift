//
//  GB2260Tests.swift
//  GB2260Tests
//
//  Created by Di Wu on 4/17/16.
//

import XCTest
@testable import GB2260

class GB2260Tests: XCTestCase {
  private let db: GB2260 = GB2260()!
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testDatabaseLoading() {
    let db = GB2260()
    XCTAssertTrue(db != nil)
  }

  func testDivision() {
    let division = db["110000"]
    let division2 = db.division(of: "110000")
    XCTAssertEqual(division, division2)
  }

  func testProvince() {
    let division = db["110000"]
    XCTAssertNotNil(division)
    XCTAssertEqual(division!.name, "北京市")
    XCTAssertEqual(division!.description, "北京市")
    XCTAssertEqual(division!.revision, db.revision.rawValue)
    XCTAssertEqual("110000", division!.code)
  }

  func testPrefecture() {
    let division = db["110100"]
    XCTAssertNotNil(division)
    XCTAssertEqual(division!.province?.name, "北京市")
    XCTAssertEqual(division!.name, "市辖区")
    XCTAssertEqual(division!.description, "北京市 市辖区")
  }

  func testCountry() {
    let division = db["110101"]
    XCTAssertNotNil(division)
    XCTAssertEqual(division!.province?.name, "北京市")
    XCTAssertEqual(division!.prefecture?.name, "市辖区")
    XCTAssertEqual(division!.name, "东城区")
    XCTAssertEqual(division!.description, "北京市 市辖区 东城区")
  }

  func testFailedQuery() {
    XCTAssertNil(db["999999"])
    XCTAssertNil(db["2207248"])
    XCTAssertNil(db["2"])
    XCTAssertNil(db["990000"])
    XCTAssertNil(db["99"])
    XCTAssertNil(db["111"])
    XCTAssertNil(db["1109"])
    XCTAssertNil(db["999900"])
    XCTAssertNil(db["11019"])
    XCTAssertTrue(db.prefectures(of: "990000").count == 0)
    XCTAssertTrue(db.prefectures(of: "123").count == 0)
    XCTAssertTrue(db.counties(of: "110900").count == 0)
    XCTAssertTrue(db.counties(of: "9").count == 0)
  }

  func testProvinces() {
    XCTAssertTrue(db.provinces.count > 0)
  }

  func testPrefectures() {
    XCTAssertEqual(db.prefectures(of: "110000").count, 2)
  }

  func testCountries() {
    XCTAssertEqual(db.counties(of: "110100").count, 14)
  }

  func testPerformanceExample() {
    // This is an example of a performance test case.
      self.measure {
      // Put the code you want to measure the time of here.
    }
  }

}
