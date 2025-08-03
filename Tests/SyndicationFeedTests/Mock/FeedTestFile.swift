//
//  FeedTestFile.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 11/7/25.
//

import Foundation

struct FeedTestFile {
	static func contentOf(file: String) -> String {
		guard let path = Bundle.module.url(forResource: file, withExtension: "xml", subdirectory: "Resources"),
			  let content = try? String(contentsOf: path, encoding: .utf8)
		else
		{
			return ""
		}
		
		return content
	}
}

extension FeedTestFile {
	static var podcastIndex: String { contentOf(file: "podcastindex-example") }
	static var rss0_91: String { contentOf(file: "sample-rss-091") }
	static var rss0_92: String { contentOf(file: "sample-rss-092") }
	static var rss2_00: String { contentOf(file: "sample-rss-2") }
	static var applePodcast: String { contentOf(file: "iTunes") }
}

extension FeedTestFile {
	enum Failure: Error {
		case malformedContent
	}
}
