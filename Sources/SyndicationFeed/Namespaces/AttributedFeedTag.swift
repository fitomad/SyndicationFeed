//
//  AttributedFeedTag.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 25/7/25.
//

import Foundation

protocol AttributedFeedTag: FeedTag {
	associatedtype AttributeKeys: RawRepresentable where AttributeKeys.RawValue == String
}
