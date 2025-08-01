//
//  Podrool.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 1/8/25.
//

import Foundation

public struct Podroll {
	public struct RemoteItem {
		public let feedGUID: UUID
		public internal(set) var feedURL: URL?
		public internal(set) var itemGUID: String?
		public internal(set) var medium: Medium?
		public internal(set) var title: String?
	}
	
	public let remoteItems: [RemoteItem]
}
