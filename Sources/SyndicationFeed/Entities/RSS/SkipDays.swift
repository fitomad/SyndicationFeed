//
//  SkipDays.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 29/7/25.
//

import Foundation

public struct SkipDays {
	public enum Day: String {
		case monday = "Monday"
		case tuesday = "Tuesday"
		case wednesday = "Wednesday"
		case thursday = "Thursday"
		case friday = "Friday"
		case saturday = "Saturday"
		case sunday = "Sunday"
	}
	
	public let days: [Day]
}
