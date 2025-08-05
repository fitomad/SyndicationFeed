//
//  AlternateEnclosureParserDelegate.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 12/7/25.
//


import Foundation

protocol AlternateEnclosureParserDelegate: AnyObject {
	func parser(_ parser: AlternateEnclosureParser, didFinishParse alternateEnclosure: AlternateEnclosure)
	func parser(_ parser: AlternateEnclosureParser, didFailWithError error: SyndicationFeedError)
}
