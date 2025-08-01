// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public final class SyndicationFeedParser {
	private var parser: ChannelParser?
	private var channel: Channel?
	
	public convenience init(url: URL) throws(SyndicationFeedError) {
		guard let data = try? Data(contentsOf: url) else {
			throw .contentNotFound
		}
		
		self.init(data: data)
	}
	
	public convenience init(content: String) throws(SyndicationFeedError) {
		guard let data = content.data(using: .utf8) else {
			throw .malformedContent
		}
		
		self.init(data: data)
	}
	
	public init(data: Data) {
		parser = ChannelParser(data: data)
		parser?.delegate = self
	}
	
	public func parse() async throws(SyndicationFeedError) -> Channel {
		guard let parser else {
			throw .contentNotFound
		}
		
		parser.start()
		
		guard let channel else {
			throw .malformedContent
		}
		
		return channel
	}
}

extension SyndicationFeedParser: ChannelParserDelegate {
	func channelParser(_ parser: ChannelParser, didFinishParse podcast: Channel) {
		self.channel = podcast
	}
}
