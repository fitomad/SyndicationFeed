//
//  Podcast+ImageSet.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 26/7/25.
//

import Foundation

public struct ImageSet: Sendable {
	public struct Image: Sendable {
		public let url: URL
		public let with: Int
	}
	
	public let images: [ImageSet.Image]
}
