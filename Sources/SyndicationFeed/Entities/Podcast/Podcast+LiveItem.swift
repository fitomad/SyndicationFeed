//
//  Podcast+LiveItem.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 15/7/25.
//

import Foundation

extension Channel {
	public struct LiveItem: Sendable {
		public let status: String
		public let startAt: Date
		public var endAt: Date?
		
		public internal(set) var title = ""
		public internal(set) var description = ""
		public internal(set) var link: URL?
		
		public internal(set) var  guid: Guid?
		public internal(set) var  enclosure: Enclosure?
		public internal(set) var  links: [ContentLink]?
		public internal(set) var  alternateEnclosures: [AlternateEnclosure]?
		
		init(status: String, startAt: Date, endAt: Date? = nil) {
			self.status = status
			self.startAt = startAt
			self.endAt = endAt
		}
	}
}
