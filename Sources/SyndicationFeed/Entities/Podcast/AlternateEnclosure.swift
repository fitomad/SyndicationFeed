//
//  AlternateEnclosure.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 15/10/24.
//

import Foundation

public struct AlternateEnclosure {
	public internal(set) var type: String
	public internal(set) var length: Int?
	public internal(set) var bitrate: Double?
	public internal(set) var height: Int?
	public internal(set) var language: String?
	public internal(set) var title: String?
	public internal(set) var codecs: String?
	public internal(set) var isDefault: Bool?
	public internal(set) var rel: String?
	public internal(set) var sources = [Source]()
	public internal(set) var integrity: Integrity?
}

extension AlternateEnclosure {
	public struct Source {
		public let url: URL
		public let contentType: String?
	}
	
	public struct Integrity {
		public let type: String
		public let value: String
	}
}
