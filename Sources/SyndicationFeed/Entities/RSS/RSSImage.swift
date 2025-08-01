//
//  Podcast+Image.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 15/7/25.
//

import Foundation

public struct RSSImage {
	public struct Size {
		public internal(set) var width = 88
		public internal(set) var height = 31
	}
	
	public let title: String
	public let url: URL
	public let link: URL
	
	public internal(set) var size: RSSImage.Size?
	public internal(set) var description: String?
}
