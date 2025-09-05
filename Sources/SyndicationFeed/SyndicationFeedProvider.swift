//
//  SyndicationFeedService.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 2/8/25.
//


import Foundation

public protocol SyndicationFeedProvider {
	func fetchFeedFrom(url: URL) async throws -> FeedResult
	func fetchFeedFrom(content: String) async throws -> FeedResult
	func fetchFeedFrom(data: Data) async throws -> FeedResult
}
