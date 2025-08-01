//
//  LiveItemMapper.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 12/7/25.
//

import Foundation

private typealias Keys = Podcasting.LiveItem.AttributeKeys

struct LiveItemMapper {
	func mapToLiveItem(using attributes: [String : String]) throws(SyndicationFeedError) -> Channel.LiveItem {
		let iso8601DateFormatter = ISO8601DateFormatter()
		iso8601DateFormatter.formatOptions = [
			.withInternetDateTime,
			.withFractionalSeconds,
			.withTimeZone
		]
		
		guard let liveItemStatus = attributes[Keys.status.rawValue],
			  let startDateContent = attributes[Keys.start.rawValue],
			  let startDate = iso8601DateFormatter.date(from: startDateContent)
		else
		{
			throw .malformedContent
		}
		
		var liveItem = Channel.LiveItem(status: liveItemStatus, startAt: startDate)
		
		if let endDateContent = attributes[Keys.end.rawValue] {
			liveItem.endAt = iso8601DateFormatter.date(from: endDateContent)
		}
		
		return liveItem
	}
}
