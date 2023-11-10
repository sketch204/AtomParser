import Foundation

private let formatter = ISO8601DateFormatter()

let sampleUrlString = "https://google.com"
let sampleURL = URL(string: sampleUrlString)!

let sampleDateString = "2023-10-17T01:24:18+00:00"
let sampleDate = formatter.date(from: sampleDateString)!
