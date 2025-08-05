//
//  ChaptersMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

struct ChaptersMapper {
	func mapToChapter(from attributes: [String : String]) throws(SyndicationFeedError) -> Chapters {
		let urlKey = Podcasting.Chapters.AttributeKeys.url.rawValue
		
		guard let urlContent = attributes[urlKey] else {
			throw .unavailableAttribute(urlKey,
										inTag: Podcasting.Chapters.tagName)
		}
		
		guard let url = URL(string: urlContent) else {
			throw .malformedContent
		}
		
		let mimeTypeKey = Podcasting.Chapters.AttributeKeys.type.rawValue
		
		guard let mimeType = attributes[mimeTypeKey] else {
			throw .unavailableAttribute(mimeTypeKey,
										inTag: Podcasting.Chapters.tagName)
		}
		
		return Chapters(url: url, mimeType: mimeType)
	}
}
