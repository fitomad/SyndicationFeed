//
//  ChannelApplePodcastHandler.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 29/7/25.
//

import Foundation

final class ChannelApplePodcastHandler: TagHandler {
	private var details = Channel.Apple()
	weak var nextHandler: (any TagHandler)?
	
	func processTag(_ tagName: String, text: String, withAttributes attributesDict: [String : String]) throws(SyndicationFeedError) {
		switch tagName {
			case Apple.Image.tagName:
				let mapper = AppleImageMapper()
				let url = try mapper.mapToImage(from: attributesDict)
				details.imageURL = url
			case Apple.Category.tagName:
				let mapper = AppleCategoryMapper()
				let category = try mapper.mapToCategory(from: attributesDict)
				addCategory(category)
			case Apple.Explicit.tagName:
				details.isExplicit = text.lowercased() == "true"
			case Apple.Author.tagName:
				details.author = text
			case Apple.Title.tagName:
				details.title = text
			case Apple.PodcastType.tagName:
				details.channelType = ChannelType(rawValue: text)
			case Apple.NewFeedURL.tagName:
				details.newFeedUrl = URL(string: text)
			case Apple.Block.tagName:
				details.isBlocked = text.lowercased() == "yes"
			case Apple.Complete.tagName:
				details.isComplete = text.lowercased() == "yes"
			case Apple.ApplePodcastsVerify.tagName:
				details.applePodcastVerify = text
			case Apple.Summary.tagName:
				details.summary = text
			case Apple.Subtitle.tagName:
				details.subtitle = text
			default:
				try nextHandler?.processTag(tagName, text: text, withAttributes: attributesDict)
		}
	}
	
	private func addCategory(_ category: String?) {
		if details.categories == nil {
			details.categories = [String]()
		}
		
		if let category {
			details.categories?.append(category)
		}
	}
}

extension ChannelApplePodcastHandler: ChannelTagHandler {
	func applyChanges(to channel: inout Channel) {
		channel.iTunes = details
	}
}
