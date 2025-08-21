//
//  SyndicationFeed.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 2/8/25.
//


import Foundation

public final class SyndicationFeed: SyndicationFeedService {
	private var parser: SyndicationFeedParser?
	
	// I hate empty functions so...
	public init() {
		parser = nil
	}
	
	public func fetchFeedFrom(url: URL) async throws(SyndicationFeedError) -> FeedResult {
		parser = try SyndicationFeedParser(url: url)
		let feedResult = try await parser?.parse()
		
		guard let feedResult else {
			throw .contentNotFound
		}
		
		return feedResult
	}
	
	public func fetchFeedFrom(content: String) async throws(SyndicationFeedError) -> FeedResult {
		parser = try SyndicationFeedParser(content: content)
		let feedResult = try await parser?.parse()
		
		guard let feedResult else {
			throw .contentNotFound
		}
		
		return feedResult
	}
	
	public func fetchFeedFrom(data: Data) async throws(SyndicationFeedError) -> FeedResult {
		parser = SyndicationFeedParser(data: data)
		let feedResult = try await parser?.parse()
		
		guard let feedResult else {
			throw .contentNotFound
		}
		
		return feedResult
	}
}
