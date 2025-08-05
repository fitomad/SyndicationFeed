//
//  AppleImageMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 1/8/25.
//

import Foundation

private typealias Keys = Apple.Image.AttributeKeys

struct AppleImageMapper {
	func mapToImage(from attributes: [String : String]) throws(SyndicationFeedError) -> URL {
		guard let hrefString = attributes[Keys.href.rawValue] else {
			throw .unavailableAttribute(Keys.href.rawValue, inTag: Apple.Image.tagName)
		}
		
		guard let hrefURL = URL(string: hrefString) else {
			throw .malformedAttributeValue(hrefString,
										   attribute: Keys.href.rawValue,
										   tag: Apple.Image.tagName)
		}
		
		return hrefURL
	}
}
