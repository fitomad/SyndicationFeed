//
//  ItemApplePodcastHandler.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

final class ItemApplePodcastHandler: TagHandler {
	var details = Item.Apple()
	var nextHandler: (any TagHandler)?
	
	func processTag(_ tagName: String, text: String, withAttributes attributesDict: [String : String]) {
		switch tagName {
			case Apple.Duration.tagName:
				let mapper = AppleDurationMapper()
				if let seconds = try? mapper.mapToDuration(from: text) {
					details.duration = seconds
				}
			case Apple.Image.tagName:
				details.imageURL = URL(string: text)
			case Apple.Explicit.tagName:
				details.isExplicit = (text.lowercased() == "yes")
			case Apple.Title.tagName:
				details.title = text
			case Apple.EpisodeNumber.tagName:
				details.episodeNumber = Int(text)
			case Apple.SeasonNumber.tagName:
				details.seasonNumber = Int(text)
			case Apple.EpisodeType.tagName:
				details.episodeType = EpisodeType(rawValue: text)
			case Apple.Block.tagName:
				details.isBlocked = (text.lowercased() == "yes")
			default:
				nextHandler?.processTag(tagName, text: text, withAttributes: attributesDict)
		}
	}
}

extension ItemApplePodcastHandler: ItemTagHandler {
	func applyChanges(to item: inout Item) {
		item.iTunes = details
	}
}
