//
//  ImageParserDelegate.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 12/7/25.
//

import Foundation

protocol ImageParserDelegate: AnyObject {
	func imageParser(_ parser: ImageParser, didFinishParse image: RSSImage)
	func imageParser(_ parser: ImageParser, didFailWithError error: SyndicationFeedError)
}
