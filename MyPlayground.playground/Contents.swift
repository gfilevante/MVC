//: Playground - noun: a place where people can play

import UIKit

var str = "2016-03-01T12:39:22.745Z"
let RFC3339DateFormatter = DateFormatter()
RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
let date = Date(timeIntervalSinceReferenceDate: 118800)
print(RFC3339DateFormatter.string(from: date))
print(RFC3339DateFormatter.date(from: str) ?? "-")
print(RFC3339DateFormatter.string(from: RFC3339DateFormatter.date(from: str)!))


let formatter = DateFormatter()
formatter.locale = Locale(identifier: "es_ES")
formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
//formatter.timeZone = TimeZone(identifier: "ES")
print(formatter.string(from: date))
print(formatter.string(from: RFC3339DateFormatter.date(from: str)!))