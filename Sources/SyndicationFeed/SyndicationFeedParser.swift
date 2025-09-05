// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

final class SyndicationFeedParser {
	private var parser: ChannelParser?
	private var channel: Channel?
	private var parsingErrors: [SyndicationFeedError]?
	
	convenience init(url: URL) async throws(SyndicationFeedError) {
		do {
			let (data, response) = try await URLSession.shared.data(from: url)
			
			guard let httpResponse =  response as? HTTPURLResponse else {
				throw SyndicationFeedError.contentNotFound
			}
			
			switch httpResponse.statusCode {
				case 200:
					self.init(data: data)
				case 404:
					throw SyndicationFeedError.contentNotFound
				default:
					throw SyndicationFeedError.httpError(code: httpResponse.statusCode)
			}
			
			self.init(data: data)
		} catch {
			throw .contentNotFound
		}
	}
	
	convenience init(content: String) throws(SyndicationFeedError) {
		guard let data = content.data(using: .utf8) else {
			throw .malformedContent
		}
		
		self.init(data: data)
	}
	
	init(data: Data) {
		parser = ChannelParser(data: data)
		parser?.delegate = self
	}
	
	func parse() async throws(SyndicationFeedError) -> FeedResult {
		guard let parser else {
			throw .contentNotFound
		}
		
		parser.start()
		
		guard let channel else {
			throw .malformedContent
		}
		
		return FeedResult(channel: channel, parsingErrors: parsingErrors)
	}
}

extension SyndicationFeedParser: ChannelParserDelegate {
	func channelParser(_ parser: ChannelParser, didFinishParse podcast: Channel, withParsingErrorsFound error: [SyndicationFeedError]) {
		self.channel = podcast
	}
}
