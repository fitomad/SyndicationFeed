//
//  Apple.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 12/7/25.
//

import Foundation

enum Apple {
	static var channelTags: [String] {
		[
			Apple.Image.tagName,
			Apple.Category.tagName,
			Apple.Explicit.tagName,
			Apple.Author.tagName,
			Apple.Title.tagName,
			Apple.PodcastType.tagName,
			Apple.NewFeedURL.tagName,
			Apple.Block.tagName,
			Apple.Complete.tagName,
			Apple.ApplePodcastsVerify.tagName
		]
	}
	
	static var itemTags: [String] {
		[
			Apple.Duration.tagName,
			Apple.Image.tagName,
			Apple.Explicit.tagName,
			Apple.Title.tagName,
			Apple.EpisodeNumber.tagName,
			Apple.SeasonNumber.tagName,
			Apple.EpisodeType.tagName,
			Apple.Block.tagName
		]
	}
	
	enum Author: FeedTag {
		static let tagName = "itunes:author"
	}
	
	enum Explicit: FeedTag {
		static let tagName: String = "itunes:explicit"
	}
	
	enum PodcastType: FeedTag {
		static let tagName: String = "itunes:type"
	}
	
	enum Image: AttributedFeedTag {
		static let tagName = "itunes:image"
		
		enum AttributeKeys: String {
			case href = "href"
		}
	}
	
	enum Name: FeedTag {
		static let tagName = "itunes:name"
	}
	
	enum Email: FeedTag {
		static let tagName = "itunes:email"
	}
	
	enum EpisodeType: FeedTag {
		static let tagName = "itunes:episodeType"
	}
	
	enum Title: FeedTag {
		static let tagName = "itunes:title"
	}
	
	enum Duration: FeedTag {
		static let tagName = "itunes:duration"
	}
	
	enum EpisodeNumber: FeedTag {
		static let tagName = "itunes:episode"
	}
	
	enum SeasonNumber: FeedTag {
		static let tagName = "itunes:season"
	}
	
	enum NewFeedURL: FeedTag {
		static let tagName = "itunes:new-feed-url"
	}
	
	enum Block: FeedTag {
		static let tagName = "itunes:block"
	}
	
	enum Complete: FeedTag {
		static let tagName = "itunes:complete"
	}
	
	enum ApplePodcastsVerify: FeedTag {
		static let tagName = "itunes:applepodcastsverify"
	}
	
	enum Subtitle: FeedTag {
		static let tagName = "itunes:subtitle"
	}
	
	enum Summary: FeedTag {
		static let tagName = "itunes:summary"
	}
	
	enum Keywords: FeedTag {
		static let tagName = "itunes:keywords"
	}
	
	enum Category: AttributedFeedTag {
		static let tagName = "itunes:category"
		
		enum AttributeKeys: String {
			case text = "text"
		}
	}
}
