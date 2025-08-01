//
//  AppleCategoryMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 1/8/25.
//

import Foundation

private typealias Keys = Apple.Category.AttributeKeys

struct AppleCategoryMapper {
	func mapToCategory(from attributes: [String : String]) throws(SyndicationFeedError) -> String {
		guard let categoryString = attributes[Keys.text.rawValue] else {
			throw .unavailableAttribute(Keys.text.rawValue, inTag: Apple.Category.tagName)
		}
		
		return categoryString
	}
}
