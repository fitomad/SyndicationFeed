//
//  UpdateFrequencyMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 1/8/25.
//

import Foundation

private typealias Keys = Podcasting.UpdateFrequency.AttributeKeys

struct UpdateFrequencyMapper {
	func mapToUpdateFrequency(using attributes: [String : String], text: String) -> UpdateFrequency {
		var updateFrequency = UpdateFrequency(title: text)
		
		if let startDateString = attributes[Keys.dtstart.rawValue],
		   let startDateValue = ISO8601DateFormatter().date(from: startDateString)
		{
			updateFrequency.updatingStartAt = startDateValue
		}
		
		if let isCompleteValue = attributes[Keys.complete.rawValue] {
			updateFrequency.isComplete = isCompleteValue == "true"
		}
		
		if let rulesList = attributes[Keys.rrule.rawValue] {
			applyRules(rulesList, to: &updateFrequency)
		}
		
		return updateFrequency
	}
	
	private func applyRules(_ rulesList: String, to updateFrequency: inout UpdateFrequency) {
		let rules = rulesList.split(separator: ";")
		
		rules.forEach { rule in
			let regex = /#(?<key>[\w]+)=(?<value>[\S]*)#/
			
			if let match = try? regex.wholeMatch(in: rule) {
				let value = String(match.output.value)
				
				switch match.output.key {
					case "FREQ":
						updateFrequency.frequency = UpdateFrequency.Frequence(rawValue: value)
					case "UNTIL":
						updateFrequency.untilDate = ISO8601DateFormatter().date(from: value)
					case "BYDAY":
						updateFrequency.weekday = UpdateFrequency.Weekday(rawValue: value)
					case "BYMONTH":
						if let monthNumber = Int(value) {
							updateFrequency.byMonth = UpdateFrequency.Month(rawValue: monthNumber)
						}
					case "INTERVAL":
						if let interval = Int(value) {
							updateFrequency.interval = interval
						}
					default:
						break
				}
			}
			
		}
	}
}
