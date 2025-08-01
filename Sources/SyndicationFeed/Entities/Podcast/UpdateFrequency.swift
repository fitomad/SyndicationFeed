//
//  UpdateFrequency.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 1/8/25.
//

import Foundation

public struct UpdateFrequency {
	public enum Frequence: String {
		case secondly = "SECONDLY"
		case minutely = "MINUTELY"
		case hourly = "HOURLY"
		case daily = "DAILY"
		case weekly = "WEEKLY"
		case monthly = "MONTHLY"
		case yearly = "YEARLY"
	}
	
	public enum Weekday: String {
		case sunday = "SU"
		case monday = "MO"
		case tuesday = "TU"
		case wednesday = "WE"
		case thursday = "TH"
		case friday = "FR"
		case saturday = "SA"
	}
	
	public enum Month: Int {
		case january = 1
		case february = 2
		case march = 3
		case april = 4
		case may = 5
		case june = 6
		case july = 7
		case august = 8
		case september = 9
		case october = 10
		case november = 11
		case december = 12
	}
	
	public let title: String
	
	public internal(set) var frequency: Frequence?
	public internal(set) var interval: Int?
	public internal(set) var weekday: Weekday?
	public internal(set) var byMonth: Month?
	
	public internal(set) var isComplete: Bool?
	
	public internal(set) var updatingStartAt: Date?
	public internal(set) var untilDate: Date?
}
