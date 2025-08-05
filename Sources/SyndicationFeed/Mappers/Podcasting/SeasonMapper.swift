//
//  SeasonMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

struct SeasonMapper {
	func mapToSeason(from attributes: [String : String], seasonValue: String) throws(SyndicationFeedError) -> Season  {
		guard let seasonNumber = Int(seasonValue) else {
			throw SyndicationFeedError.malformedContent
		}
		
		return Season(number: seasonNumber,
					  name: attributes[Podcasting.Season.AttributeKeys.name.rawValue])
	}
}
