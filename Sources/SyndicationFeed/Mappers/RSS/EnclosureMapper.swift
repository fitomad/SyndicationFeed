//
//  EnclosureMapper.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 14/7/25.
//

import Foundation

struct EnclosureMapper {
	func mapToEnclosure(from attributes: [String : String]) throws(SyndicationFeedError) -> Enclosure {
		guard let urlContent = attributes[RSS.Enclosure.AttributeKeys.url.rawValue] else {
			throw .unavailableAttribute(RSS.Enclosure.AttributeKeys.url.rawValue,
										inTag: RSS.Enclosure.tagName)
		}
		
		guard let enclosureURL = URL(string: urlContent) else {
			throw .malformedAttributeValue(urlContent,
										   attribute: RSS.Enclosure.AttributeKeys.url.rawValue,
										   tag: RSS.Enclosure.tagName)
		}
		
		guard let typeContent = attributes[RSS.Enclosure.AttributeKeys.type.rawValue] else {
			throw .unavailableAttribute(RSS.Enclosure.AttributeKeys.type.rawValue,
										inTag: RSS.Enclosure.tagName)
		}
		
		guard let lengtContent = attributes[RSS.Enclosure.AttributeKeys.length.rawValue] else {
			throw .unavailableAttribute(RSS.Enclosure.AttributeKeys.length.rawValue,
										inTag: RSS.Enclosure.tagName)
		}
		
		guard let enclosureLength = Int(lengtContent) else {
			throw .malformedAttributeValue(lengtContent,
										   attribute: RSS.Enclosure.AttributeKeys.length.rawValue,
										   tag: RSS.Enclosure.tagName)
		}
		
		return Enclosure(url: enclosureURL,
						 length: enclosureLength,
						 type: typeContent)
	}
}
