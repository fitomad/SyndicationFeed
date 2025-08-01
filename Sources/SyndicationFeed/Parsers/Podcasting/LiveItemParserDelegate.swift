//
//  LiveItemParserDelegate.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 12/7/25.
//


import Foundation

protocol LiveItemParserDelegate: AnyObject {
	func parser(_ parser: LiveItemParser, didFinishParse liveItem: Channel.LiveItem)
	func parser(_ parser: LiveItemParser, didFailWithError error: SyndicationFeedError)
}
