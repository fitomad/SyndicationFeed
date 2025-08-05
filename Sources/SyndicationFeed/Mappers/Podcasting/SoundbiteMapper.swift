//
//  SoundbiteMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

struct SoundbiteMapper {
	func mapToSoundbite(from attributes: [String : String], title: String) throws(SyndicationFeedError) -> Soundbite {
		let startTimeKey = Podcasting.Soundbite.AttributeKeys.startTime.rawValue
		let durationKey = Podcasting.Soundbite.AttributeKeys.duration.rawValue
		
		guard let startTimeContent = attributes[startTimeKey] else {
			throw SyndicationFeedError.unavailableAttribute(startTimeKey,
																  inTag: Podcasting.Soundbite.tagName)
		}
		
		guard let durationContent = attributes[durationKey] else {
			throw SyndicationFeedError.unavailableAttribute(startTimeKey,
																  inTag: Podcasting.Soundbite.tagName)
		}
		
		guard let startTimeValue = Double(startTimeContent),
			  let durationValue = Double(durationContent)
		else
		{
			throw SyndicationFeedError.malformedContent
		}
		
		let titleValue = title.isEmpty ? nil : title
		
		return Soundbite(startTime: startTimeValue,
						 duration: durationValue,
						 title: titleValue)
	}
}
