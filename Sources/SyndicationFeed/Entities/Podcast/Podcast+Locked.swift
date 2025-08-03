//
//  Podcast+Locked.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 15/7/25.
//

import Foundation

extension Channel {
	public struct Locked: Sendable {
		public let value: String
		public let owner: String?
		
		public var isLocked: Bool {
			return value.lowercased() == "yes"
		}
	}
}
