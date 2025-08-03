//
//  Podcast+Block.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 15/7/25.
//

import Foundation

public struct Block: Sendable {
	public let value: String
	public let service: PodcastService?
	
	public var isBlocked: Bool {
		return value.lowercased() == "yes"
	}
}
