import Foundation
import Testing
@testable import DateExtensions

@Test func testPlus() async throws {
    let anchorDate = dateFor(year: 2025, month: 1, day: 1)

    #expect(anchorDate.plus(days: 1) == dateFor(year: 2025, month: 1, day: 2))
    #expect(anchorDate.plus(days: 2) == dateFor(year: 2025, month: 1, day: 3))
    #expect(anchorDate.plus(days: 35) == dateFor(year: 2025, month: 2, day: 5))
    #expect(anchorDate.plus(days: -1) == dateFor(year: 2024, month: 12, day: 31))
    #expect(anchorDate.plus(days: -2) == dateFor(year: 2024, month: 12, day: 30))

    #expect(anchorDate.plus(weeks: 1) == dateFor(year: 2025, month: 1, day: 8))
    #expect(anchorDate.plus(weeks: 2) == dateFor(year: 2025, month: 1, day: 15))
    #expect(anchorDate.plus(weeks: 14) == dateFor(year: 2025, month: 4, day: 9))
    #expect(anchorDate.plus(weeks: -1) == dateFor(year: 2024, month: 12, day: 25))
    #expect(anchorDate.plus(weeks: -2) == dateFor(year: 2024, month: 12, day: 18))

    #expect(anchorDate.plus(months: 1) == dateFor(year: 2025, month: 2, day: 1))
    #expect(anchorDate.plus(months: 2) == dateFor(year: 2025, month: 3, day: 1))
    #expect(anchorDate.plus(months: 14) == dateFor(year: 2026, month: 3, day: 1))
    #expect(anchorDate.plus(months: -1) == dateFor(year: 2024, month: 12, day: 1))
    #expect(anchorDate.plus(months: -2) == dateFor(year: 2024, month: 11, day: 1))

    #expect(anchorDate.plus(years: 1) == dateFor(year: 2026, month: 1, day: 1))
    #expect(anchorDate.plus(years: 2) == dateFor(year: 2027, month: 1, day: 1))
    #expect(anchorDate.plus(years: 14) == dateFor(year: 2039, month: 1, day: 1))
    #expect(anchorDate.plus(years: -1) == dateFor(year: 2024, month: 1, day: 1))
    #expect(anchorDate.plus(years: -2) == dateFor(year: 2023, month: 1, day: 1))
}

@Test func startOfDay() async throws {
    let anchorDate = Date.now

    let anchorComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: anchorDate)
    let startOfDayComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: anchorDate.startOfDay)

    #expect(anchorComponents.year == startOfDayComponents.year)
    #expect(anchorComponents.month == startOfDayComponents.month)
    #expect(anchorComponents.day == startOfDayComponents.day)

    #expect(startOfDayComponents.hour == 0)
    #expect(startOfDayComponents.minute == 0)
    #expect(startOfDayComponents.second == 0)
    #expect(startOfDayComponents.nanosecond == 0)
}

@Test func startAndEndOfMonth() async throws {
    let anchorDate = dateFor(year: 2024, month: 2, day: 13, hour: 8, minute: 12, second: 47)

    let startOfMonthComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: anchorDate.startOfMonth)
    let endOfMonthComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: anchorDate.endOfMonth)

    #expect(startOfMonthComponents.year == 2024)
    #expect(startOfMonthComponents.month == 2)
    #expect(startOfMonthComponents.day == 1)
    #expect(startOfMonthComponents.hour == 0)
    #expect(startOfMonthComponents.minute == 0)
    #expect(startOfMonthComponents.second == 0)
    #expect(startOfMonthComponents.nanosecond == 0)

    #expect(endOfMonthComponents.year == 2024)
    #expect(endOfMonthComponents.month == 2)
    #expect(endOfMonthComponents.day == 29)
    #expect(endOfMonthComponents.hour == 23)
    #expect(endOfMonthComponents.minute == 59)
    #expect(endOfMonthComponents.second == 59)
    #expect(endOfMonthComponents.nanosecond == 0)
}

func dateFor(year: Int, month: Int, day: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> Date {
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = day
    dateComponents.hour = hour ?? 0
    dateComponents.minute = minute ?? 0
    dateComponents.second = second ?? 0

    return Calendar.current.date(from: dateComponents)!
}
