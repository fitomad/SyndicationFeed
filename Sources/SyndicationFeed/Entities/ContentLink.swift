//
//  ContentLink.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 12/7/25.
//

import Foundation

public struct ContentLink {
	let link: URL
	let media: String?
	
	init(link: URL, media: String? = nil) {
		self.link = link
		self.media = media
	}
}
