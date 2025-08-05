//
//  EpisodeMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//


import Foundation

struct EpisodeMapper {
	func mapToEpisode(from attributes: [String : String], episodeValue: String) throws(SyndicationFeedError) -> Episode  {
		guard let episodeNumber = Int(episodeValue) else {
			throw .malformedContent
		}
		
		return Episode(number: episodeNumber,
					   name: attributes[Podcasting.Episode.AttributeKeys.display.rawValue])
	}
}
