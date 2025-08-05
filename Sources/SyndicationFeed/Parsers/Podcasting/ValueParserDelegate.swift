//
//  ValueParserDelegate.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 27/7/25.
//

import Foundation

protocol ValueParserDelegate: AnyObject {
	func parser(_ parser: ValueParser, didFinishParse value: PodcastValue)
	func parser(_ parser: ValueParser, didFailWithError error: SyndicationFeedError)
}
