//
//  GUIDMapper.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 14/7/25.
//

import Foundation

struct GUIDMapper {
	func mapToGUID(from attributes: [String : String], urlContent: String) throws(SyndicationFeedError) -> Guid {
		guard let guidURL = URL(string: urlContent) else {
			throw .malformedTagValue(urlContent,
									 tag: RSS.GUID.tagName)
		}
		
		if let isPermalinkContent = attributes[RSS.GUID.AttributeKeys.isPermalink.rawValue] {
			let isPermanentLink = isPermalinkContent.lowercased() == "true"
			return Guid(link: guidURL, isPermaLink: isPermanentLink)
		}
		
		return Guid(link: guidURL)
	}
}
