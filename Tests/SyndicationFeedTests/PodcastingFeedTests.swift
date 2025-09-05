//
//  PodcastingFeedTests.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/8/25.
//

import Foundation
import Testing

@testable import SyndicationFeed


@Suite("Podcasting namesapce tests")
struct PodcastingFeedTests {
	@Test("", .tags(.podcastingNamespace))
	func episodeTranscription() async throws {
		guard let feedData = FeedTestFile.strawberrySpring.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.items.isEmpty == false)
		
		channel.items.forEach { item in
			#expect(item.podcasting?.transcripts?.count == 3)
		}
		
		let firstItem = channel.items[0]
		
		#expect(firstItem.podcasting?.transcripts != nil)
		
		#expect(firstItem.podcasting?.transcripts?[0].language == "en-us")
		#expect(firstItem.podcasting?.transcripts?[0].link == URL(string: "https://api.omny.fm/orgs/e73c998e-6e60-432f-8610-ae210140c5b1/clips/c7952369-056c-49ed-9ddf-b097000474cc/transcript?format=SubRip&t=1713805740"))
		#expect(firstItem.podcasting?.transcripts?[0].mimeType == "application/srt")
		
		#expect(firstItem.podcasting?.transcripts?[1].language == "en-us")
		#expect(firstItem.podcasting?.transcripts?[1].link == URL(string: "https://api.omny.fm/orgs/e73c998e-6e60-432f-8610-ae210140c5b1/clips/c7952369-056c-49ed-9ddf-b097000474cc/transcript?format=WebVTT&t=1713805740"))
		#expect(firstItem.podcasting?.transcripts?[1].mimeType == "text/vtt")
		
		#expect(firstItem.podcasting?.transcripts?[2].language == "en-us")
		#expect(firstItem.podcasting?.transcripts?[2].link == URL(string: "https://api.omny.fm/orgs/e73c998e-6e60-432f-8610-ae210140c5b1/clips/c7952369-056c-49ed-9ddf-b097000474cc/transcript?format=TextWithTimestamps&t=1713805740"))
		#expect(firstItem.podcasting?.transcripts?[2].mimeType == "text/plain")
	}
	
	@Test("Channel GUID", .tags(.podcastingNamespace))
	func channelGUID() async throws {
		guard let feedData = FeedTestFile.podcastIndex.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.podcasting?.guid?.uuidString == "36a159c6-dfa9-5ed4-a83e-89612c0f7897".uppercased())
	}
	
	@Test("Channel license", .tags(.podcastingNamespace))
	func channelLicense() async throws {
		guard let feedData = FeedTestFile.podcastIndex.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.podcasting?.license?.title == "my-podcast-license-v1")
		#expect(channel.podcasting?.license?.link?.absoluteString == "https://example.org/mypodcastlicense/full.pdf")
	}
	
	@Test("Channel locked", .tags(.podcastingNamespace))
	func channelLocked() async throws {
		guard let feedData = FeedTestFile.podcastIndex.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.podcasting?.locked?.isLocked == true)
		#expect(channel.podcasting?.locked?.owner == "podcastowner@example.com")
		
	}
	
	@Test("Channel block", .tags(.podcastingNamespace))
	func channelBlock() async throws {
		guard let feedData = FeedTestFile.podcastIndex.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.podcasting?.blocks?.isEmpty == false)
		#expect(channel.podcasting?.blocks?.count == 3)
		#expect(channel.podcasting?.blocks?.isGenerallyBlocked == true)
		
		#expect(channel.podcasting?.blocks?.isChannelBlockedFor(service: .google) == false)
		#expect(channel.podcasting?.blocks?.isChannelBlockedFor(service: .amazon) == false)
		#expect(channel.podcasting?.blocks?.isChannelBlockedFor(service: .spotify) == nil)
	}
	
	@Test("Channel Funding", .tags(.podcastingNamespace))
	func channelFunding() async throws {
		guard let feedData = FeedTestFile.podcastIndex.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.podcasting?.funding != nil)
		#expect(channel.podcasting?.funding?.link.absoluteString == "https://example.com/donate")
		#expect(channel.podcasting?.funding?.message == "Support the show!")
	}
	
	@Test("Channel Location", .tags(.podcastingNamespace))
	func channelLocation() async throws {
		guard let feedData = FeedTestFile.podcastIndex.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.podcasting?.locations?.isEmpty == false)
		#expect(channel.podcasting?.locations?.first?.openStreetMapId == "R113314")
		#expect(channel.podcasting?.locations?.first?.coordinates?.latitude == 30.2672)
		#expect(channel.podcasting?.locations?.first?.coordinates?.longitude == 97.7431)
		#expect(channel.podcasting?.locations?.first?.name == "Austin, TX")
	}
	
	@Test("Channel medium", .tags(.podcastingNamespace))
	func channelMedium() async throws {
		guard let feedData = FeedTestFile.podcastIndex.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.podcasting?.medium == .podcast)
	}
	
	@Test("Channel Trailer", .tags(.podcastingNamespace))
	func channelTrailer() async throws {
		guard let feedData = FeedTestFile.podcastIndex.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.podcasting?.trailers?.isEmpty == false)
		#expect(channel.podcasting?.trailers?.count == 1)
		
		#expect(channel.podcasting?.trailers?.first?.title == "Coming April 1st, 2021")
		#expect(channel.podcasting?.trailers?.first?.type == "audio/mp3")
		#expect(channel.podcasting?.trailers?.first?.length == 12345678)
		#expect(channel.podcasting?.trailers?.first?.link.absoluteString == "https://example.org/trailers/teaser")
		#expect(channel.podcasting?.trailers?.first?.publishedAt != nil)
		
		guard let publishedAt = channel.podcasting?.trailers?.first?.publishedAt else {
			fatalError("No date available")
		}
		
		let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: publishedAt)
		#expect(dateComponents.day == 1)
		#expect(dateComponents.month == 4)
		#expect(dateComponents.year == 2021)
		#expect(dateComponents.minute == 0)
		#expect(dateComponents.second == 0)
	}
	
	@Test("Channel Value", .tags(.podcastingNamespace))
	func channelValue() async throws {
		guard let feedData = FeedTestFile.podcastIndex.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.podcasting?.values?.isEmpty == false)
		#expect(channel.podcasting?.values?.count == 1)
		
		#expect(channel.podcasting?.values?.first?.kind == "lightning")
		#expect(channel.podcasting?.values?.first?.method == "keysend")
		#expect(channel.podcasting?.values?.first?.suggestedAmmount == 0.00000005)
		#expect(channel.podcasting?.values?.first?.recipients.isEmpty == false)
		#expect(channel.podcasting?.values?.first?.recipients.count == 2)
		
		#expect(channel.podcasting?.values?.first?.recipients.first?.name == "podcaster")
		#expect(channel.podcasting?.values?.first?.recipients.first?.type == "node")
		#expect(channel.podcasting?.values?.first?.recipients.first?.address == "036557ea56b3b86f08be31bcd2557cae8021b0e3a9413f0c0e52625c6696972e57")
		#expect(channel.podcasting?.values?.first?.recipients.first?.splitValue == 99)
	}
	
	@Test("Channel LiveItem", .tags(.podcastingNamespace))
	func channelLiveItem() async throws {
		guard let feedData = FeedTestFile.podcastIndex.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.podcasting?.liveItems?.isEmpty == false)
		#expect(channel.podcasting?.liveItems?.count == 1)
		
		#expect(channel.podcasting?.liveItems?.first?.status == "live")
		#expect(channel.podcasting?.liveItems?.first?.startAt != nil )
		#expect(channel.podcasting?.liveItems?.first?.endAt != nil)
		
		#expect(channel.podcasting?.liveItems?.first?.title == "Podcasting 2.0 Live Show")
		#expect(channel.podcasting?.liveItems?.first?.description.starts(with: "A look into the future of podcasting") == true)
		#expect(channel.podcasting?.liveItems?.first?.link?.absoluteString ==  "https://example.com/podcast/live")
		
		#expect(channel.podcasting?.liveItems?.first?.guid?.isPermaLink == true)
		#expect(channel.podcasting?.liveItems?.first?.guid?.link.absoluteString == "https://example.com/live")
		
		#expect(channel.podcasting?.liveItems?.first?.alternateEnclosures?.isEmpty == false)
		#expect(channel.podcasting?.liveItems?.first?.alternateEnclosures?.count == 1)
		
		#expect(channel.podcasting?.liveItems?.first?.alternateEnclosures?.first?.type == "audio/mpeg")
		#expect(channel.podcasting?.liveItems?.first?.alternateEnclosures?.first?.length == 312)
		#expect(channel.podcasting?.liveItems?.first?.alternateEnclosures?.first?.isDefault == true)
		#expect(channel.podcasting?.liveItems?.first?.alternateEnclosures?.first?.sources.isEmpty == false)
		#expect(channel.podcasting?.liveItems?.first?.alternateEnclosures?.first?.sources.count == 1)
		#expect(channel.podcasting?.liveItems?.first?.alternateEnclosures?.first?.sources.first?.url.absoluteString == "https://example.com/pc20/livestream")
		
		#expect(channel.podcasting?.liveItems?.first?.links?.isEmpty == false)
		#expect(channel.podcasting?.liveItems?.first?.links?.count == 2)
		
		#expect(channel.podcasting?.liveItems?.first?.links?.first?.media == "YouTube!")
		#expect(channel.podcasting?.liveItems?.first?.links?.first?.link.absoluteString == "https://youtube.com/pc20/livestream")
	}
	
	@Test("Feed file with XML headers", .tags(.podcastingNamespace))
	func testWithXmlHeaders() async throws {
		guard let feedData = FeedTestFile.pepites.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.title == "Pépites et Nuggets - Le podcast!")
		#expect(channel.link?.absoluteString == "http://pepitesetnuggets.com/")
		#expect(channel.description == "On fait des vidéos de jeux mais parfois on cause simplement... de jeux vidéo!")
		#expect(channel.language == "fr-FR")
		#expect(channel.copyright == "© 2016 Pépites et Nuggets")
	}
}

extension Tag {
	@Tag static var podcastingNamespace: Tag
}
