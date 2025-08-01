//
//  PodcastFeedParserError.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 15/10/24.
//

import Foundation

public enum SyndicationFeedError: Error {
	case malformedContent
	case contentNotFound
	case unavailableTag(_ name: String, inElement: String)
	case unavailableAttribute(_ name: String, inTag: String)
	case malformedTagValue(_ value: String, tag: String)
	case malformedAttributeValue(_ value: String, attribute: String, tag: String)
}
