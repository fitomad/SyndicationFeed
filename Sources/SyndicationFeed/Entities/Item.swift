//
//  Episode.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 11/7/25.
//

import Foundation

public struct Item {
	public var title: String?
	public var description: String?
	public var link: URL?
	public var author: String?
	public var categories: [String]?
	public var commentsURL: URL?
	public var enclosure: Enclosure?
	public var guid: Guid?
	public var publicationDate: Date?
	public var source: RSSSource?
	
	public var podcasting: Podcasting?
	public var iTunes: Apple?
}

extension Item {
	public struct Podcasting {
		public var alternateEnclosures: [AlternateEnclosure]?
		public var transcripts: [Transcript]?
		public var season: Season?
		public var episode: Episode?
		public var chapters: Chapters?
		public var chat: Chat?
		public var contentLinks: [ContentLink]?
		public var funding: Funding?
		public var images: [PodcastImage]?
		public var imagesSet: ImageSet?
		public var license: License?
		public var locations: [Location]?
		public var personas: [Person]?
		public var socialProfiles: [SocialInteract]?
		public var soundbites: [Soundbite]?
		public var txts: [TXT]?
		public var values: [PodcastValue]?
	}
}

extension Item {
	public struct Apple {
		public var title: String?
		public var duration: Int?
		public var episodeType: EpisodeType?
		public var isExplicit: Bool?
		public var episodeNumber: Int?
		public var seasonNumber: Int?
		public var imageURL: URL?
		public var isBlocked: Bool?
	}
}
