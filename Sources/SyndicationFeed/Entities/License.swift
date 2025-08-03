//
//  License.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 11/7/25.
//

import Foundation

public struct License: Sendable {
	public let title: String
	public let link: URL?
	
	init(title: String, link: URL?) {
		self.title = title
		self.link = link
	}
}
