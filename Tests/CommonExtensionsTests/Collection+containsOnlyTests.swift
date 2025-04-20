//
//  File.swift
//  CBExtensions
//
//  Created by Matthew Corey on 4/20/25.
//

import Foundation
import Testing
@testable import CommonExtensions

@Test func testContainsOnly() async throws {
    #expect(![ "One", "Two", "Three"].containsOnly("One"))
    #expect([ "One" ].containsOnly("One"))
}
