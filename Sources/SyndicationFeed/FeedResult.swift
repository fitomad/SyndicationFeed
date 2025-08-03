//
//  FeedResult.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 2/8/25.
//


import Foundation

public struct FeedResult {
	public let channel: Channel
	public let parsingErrors: [SyndicationFeedError]?
}