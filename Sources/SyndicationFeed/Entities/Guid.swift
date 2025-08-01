//
//  Guid.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 15/10/24.
//

import Foundation

public struct Guid {
	public let isPermaLink: Bool
	public let link: URL
	
	init(link: URL, isPermaLink: Bool = true) {
		self.link = link
		self.isPermaLink = isPermaLink
	}
}
