//
//  SourceMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

struct SourceMapper {
	func mapToSource(from attributes: [String : String], text: String) throws(SyndicationFeedError)-> RSSSource {
		guard let urlContent = attributes[RSS.Source.AttributeKeys.url.rawValue] else {
			throw .unavailableAttribute(RSS.Source.AttributeKeys.url.rawValue,
										inTag: RSS.Source.tagName)
		}
		
		guard let url = URL(string: urlContent) else {
			throw .malformedAttributeValue(urlContent,
										   attribute: RSS.Source.AttributeKeys.url.rawValue,
										   tag: RSS.Source.tagName)
		}
		
		return RSSSource(title: text, link: url)
	}
}
