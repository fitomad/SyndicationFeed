//
//  FundingMapper.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 15/7/25.
//

import Foundation

struct FundingMapper {
	func mapToFunding(using attributes: [String : String], message: String) throws(SyndicationFeedError) -> Funding {
		guard let urlValue = attributes[Podcasting.Funding.AttributeKeys.url.rawValue],
			  let url = URL(string: urlValue)
		else
		{
			throw .malformedContent
		}
		
		return Funding(message: message, link: url)
	}
}
