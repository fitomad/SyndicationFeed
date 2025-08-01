import Testing
@testable import SyndicationFeed

@Suite("Podcast XML feed parser tests")
struct SyndicationFeedTests {
	@Test("", .tags(.feedParser), arguments: [ FeedTestFile.podcastIndex ])
	func parseAllMockFeeds(feedContent: String) async throws {
		guard let feedData = feedContent.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let channel = try await parser.parse()
		
		#expect(channel.title.isEmpty == false)
	}
	
	@Test("PodcastIndex example feed", .tags(.feedParser))
	func parsePodcastIndexExampleFeed() async throws {
		guard let feedData = FeedTestFile.podcastIndex.data(using: .utf8) else {
			throw FeedTestFile.Failure.malformedContent
		}
		
		let parser = SyndicationFeedParser(data: feedData)
		let channel = try await parser.parse()
		
		#expect(channel.title == "Podcasting 2.0 Namespace Example")
	}
}

extension Tag {
	@Tag static var feedParser: Tag
}
