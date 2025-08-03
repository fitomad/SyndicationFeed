//
//  ApplePodcastTests.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 1/8/25.
//

import Foundation
import Testing
@testable import SyndicationFeed


@Suite("Apple Podcast (iTunes) tests.")
struct ApplePodcastTests {
	@Test("Most common iTunes feed fields")
	func commonApplePodcastFeed() async throws {
		guard let feedData = FeedTestFile.applePodcast.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.iTunes != nil)
		
		#expect(channel.iTunes?.author != nil)
		#expect(channel.iTunes?.author == "The Sunset Explorers")
		
		#expect(channel.iTunes?.channelType == .serial)
		
		#expect(channel.iTunes?.imageURL != nil)
		#expect(channel.iTunes?.imageURL?.absoluteString == "https://applehosted.podcasts.apple.com/hiking_treks/artwork.png")
	
		#expect(channel.iTunes?.categories != nil)
		#expect(channel.iTunes?.categories?.count == 2)
		#expect(channel.iTunes?.categories?.contains("Wilderness") == true)
		
		#expect(channel.iTunes?.isExplicit == true)
		
		guard let item = channel.items.first else {
			throw SyndicationFeedError.contentNotFound
		}
		
		#expect(item.iTunes != nil)
		#expect(item.iTunes?.episodeType == .trailer)
		#expect(item.iTunes?.title == "Hiking Treks Trailer")
		#expect(item.iTunes?.duration == 1079)
		#expect(item.iTunes?.isExplicit == false)
		
		let secondItem = channel.items[1]
		
		#expect(secondItem.iTunes != nil)
		#expect(secondItem.iTunes?.episodeType == .full)
		#expect(secondItem.iTunes?.episodeNumber == 4)
		#expect(secondItem.iTunes?.seasonNumber == 2)
		#expect(secondItem.iTunes?.duration == ((10 * 60) + 24))
		#expect(secondItem.iTunes?.isExplicit == false)
	}
}

extension Tag {
	@Tag static var applePodcast: Tag
}
