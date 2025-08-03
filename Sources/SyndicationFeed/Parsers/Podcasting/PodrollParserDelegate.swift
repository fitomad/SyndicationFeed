//
//  PodrollParserDelegate.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 3/8/25.
//


import Foundation

protocol PodrollParserDelegate: AnyObject {
	func parser(_ parser: PodrollParser, didFinishParse podroll: Podroll)
	func parser(_ parser: PodrollParser, didFinishWithError error: SyndicationFeedError)
}