//
//  PodcastImage.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

public struct PodcastImage: Sendable {
	public struct Size: Sendable {
		public internal(set) var width: Int
		public internal(set) var height: Int
	}
	
	public enum Purpose: Sendable {
		case artwork
		case social
		case canvas
		case banner
		case publisher
		case circular
		case custom(_ purpose: String)
	}
	
	public let url: URL
	public let alternateText: String?
	public let aspectRatio: String?
	public let size: PodcastImage.Size?
	public let mimeType: String?
	public let purpose: PodcastImage.Purpose?
}
