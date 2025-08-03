//
//  ItemParserDelegate.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 29/7/25.
//


import Foundation

protocol ItemParserDelegate: AnyObject {
	func parser(_ parser: ItemParser, didFinishParse item: Item, withErrors parsingErrors: [SyndicationFeedError])
}
