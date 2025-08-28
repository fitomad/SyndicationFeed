import Testing
@testable import SyndicationFeed

@Suite("Podcast XML feed parser tests")
struct SyndicationFeedTests {
	@Test("All tests", .tags(.feedParser), arguments: [ FeedTestFile.podcastIndex ])
	func parseAllMockFeeds(feedContent: String) async throws {
		guard let feedData = feedContent.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.title.isEmpty == false)
	}
	
	@Test("PodcastIndex example feed", .tags(.feedParser))
	func parsePodcastIndexExampleFeed() async throws {
		guard let feedData = FeedTestFile.podcastIndex.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.title == "Podcasting 2.0 Namespace Example")
	}
	
	@Test("Feed with CDATA content", .tags(.feedParser))
	func parserFeedWithCDATAContent() async throws {
		guard let feedData = FeedTestFile.laCumbreDeLosHorrores.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let result = try await parser.parse()
		let channel = result.channel
		
		#expect(channel.title == "La cumbre de los horrores")
		#expect(channel.iTunes?.subtitle?.starts(with: #""La Cumbre de los Horrores" es una serie antológica"#) ?? false)
		#expect(channel.description?.starts(with: "<p>La Cumbre de los Horrores") ?? false)
		#expect(channel.iTunes?.summary?.starts(with: "La Cumbre de los Horrores") ?? false)
		
		#expect(channel.items.isEmpty == false)
		
		#expect(channel.items[0].title == "Episodio 4: Miseria")
		#expect(channel.items[0].iTunes?.title == "Episodio 4: Miseria")
		#expect(channel.items[0].description?.starts(with: "<p>Rebeca est&aacute; pasando un mal momento.") ?? false)
	}
}

extension Tag {
	@Tag static var feedParser: Tag
}
