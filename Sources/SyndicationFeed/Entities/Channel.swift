//
//  Podcast.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 15/10/24.
//

import Foundation

public struct Channel {
	public internal(set) var title = ""
	public internal(set) var description: String?
	public internal(set) var link: URL?
	public internal(set) var language: String?
	public internal(set) var copyright: String?
	public internal(set) var managingEditor: String?
	public internal(set) var webMaster: String?
	public internal(set) var publishedAt: Date?
	public internal(set) var lastBuildAt: Date?
	public internal(set) var categories: [String]?
	public internal(set) var generator: String?
	public internal(set) var document: URL?
	public internal(set) var cloud: Cloud?
	public internal(set) var ttl: Int?
	public internal(set) var image: RSSImage?
	public internal(set) var rating: String?
	public internal(set) var skipHours: [Int]?
	public internal(set) var skipDays: SkipDays?
	
	public internal(set) var items = [Item]()
	
	public internal(set) var podcasting: Podcasting?
	public internal(set) var iTunes: Apple?
}

extension Channel {
	public struct Podcasting {
		public internal(set) var block: Block?
		public internal(set) var chat: Chat?
		public internal(set) var funding: Funding?
		public internal(set) var guid: UUID?
		public internal(set) var images: [PodcastImage]?
		public internal(set) var imageSet: ImageSet?
		public internal(set) var license: License?
		public internal(set) var locations: [Location]?
		public internal(set) var locked: Locked?
		public internal(set) var medium: Medium?
		public internal(set) var personas: [Person]?
		public internal(set) var usesPodping: Bool?
		public internal(set) var podroll: Podroll?
		public internal(set) var socialProfiles: [SocialInteract]?
		public internal(set) var trailers: [Trailer]?
		public internal(set) var txts: [TXT]?
		public internal(set) var updateFrequency: UpdateFrequency?
		public internal(set) var liveItems: [LiveItem]?
		public internal(set) var values: [PodcastValue]?
	}
}

extension Channel {
	public struct Apple {
		public internal(set) var imageURL: URL?
		public internal(set) var categories: [String]?
		public internal(set) var isExplicit: Bool?
		public internal(set) var author: String?
		public internal(set) var title: String?
		public internal(set) var channelType: ChannelType?
		public internal(set) var newFeedUrl: URL?
		public internal(set) var isBlocked: Bool?
		public internal(set) var isComplete: Bool?
		public internal(set) var applePodcastVerify: String?
	}
}
