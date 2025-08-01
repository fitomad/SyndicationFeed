//
//  ContentLinkMapper.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 14/7/25.
//

import Foundation

struct ContentLinkMapper {
	func mapToContenLink(from attributes: [String : String], content: String) throws(SyndicationFeedError) -> ContentLink {
		guard let hrefContent = attributes[Podcasting.ContentLink.AttributeKeys.href.rawValue],
			  let hrerURL = URL(string: hrefContent)
		else
		{
			throw .malformedContent
		}
		
		return ContentLink(link: hrerURL, media: content)
	}
}
