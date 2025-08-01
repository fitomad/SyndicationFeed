//
//  ChannelParserDelegate.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 11/7/25.
//

import Foundation

protocol ChannelParserDelegate: AnyObject {
	func channelParser(_: ChannelParser, didFinishParse channel: Channel)
}
