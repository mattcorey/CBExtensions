
//
//  Date+Common.swift
//  DateExtensions
//
//  Created by Matthew Corey on 3/29/25.
//

import Foundation

extension Date {
    public var daysSince: Int {
        (Calendar.current.dateComponents([.day], from: self.startOfDay, to: Date.now.startOfDay).day) ?? 0
    }

    public func daysSince(_ date: Date) -> Int {
        (Calendar.current.dateComponents([.day], from: date.startOfDay, to: self.startOfDay).day) ?? 0
    }

    public var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    public var startOfMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self.startOfDay))!
    }

    public var endOfMonth: Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, second: -1), to: self.startOfMonth)!
    }

    public func plus(seconds: Int) -> Date {
        Calendar.current.date(byAdding: .second, value: seconds, to: self)!
    }

    public func plus(minutes: Int) -> Date {
        Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }

    public func plus(hours: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }

    public func plus(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self)!
    }

    public func plus(weeks: Int) -> Date {
        Calendar.current.date(byAdding: .weekOfYear, value: weeks, to: self)!
    }

    public func plus(months: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: months, to: self)!
    }

    public func plus(years: Int) -> Date {
        Calendar.current.date(byAdding: .year, value: years, to: self)!
    }

    public func next(dayOfMonth: Int) -> Date {
        let cal = Calendar.current
        var dateComponents = cal.dateComponents([.year, .month, .hour, .minute, .second], from: Date())
        dateComponents.day = dayOfMonth

        var date = cal.date(from: dateComponents)!
        if date.startOfDay < Date().startOfDay {
            date = date.plus(months: 1)
        }

        return date
    }
}
