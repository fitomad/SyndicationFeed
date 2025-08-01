//
//  TranscriptMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

struct TranscriptMapper {
	func mapToTranscript(from attributes: [String: String]) throws(SyndicationFeedError) -> Transcript {
		let urlKey =  Podcasting.Transcript.AttributeKeys.url.rawValue
		let typeKey =  Podcasting.Transcript.AttributeKeys.type.rawValue
		let languageKey =  Podcasting.Transcript.AttributeKeys.language.rawValue
		let relKey =  Podcasting.Transcript.AttributeKeys.rel.rawValue
		
		guard let urlValue = attributes[urlKey] else {
			throw SyndicationFeedError.unavailableAttribute(urlKey,
																  inTag: Podcasting.Transcript.tagName)
		}
		
		guard let typeValue = attributes[typeKey] else {
			throw SyndicationFeedError.unavailableAttribute(typeKey,
																  inTag: Podcasting.Transcript.tagName)
		}
		
		guard let url = URL(string: urlValue) else {
			throw SyndicationFeedError.malformedContent
		}
		
		return Transcript(link: url,
						  mimeType: typeValue,
						  language: attributes[languageKey],
						  relativeTo: attributes[relKey])
	}
}
