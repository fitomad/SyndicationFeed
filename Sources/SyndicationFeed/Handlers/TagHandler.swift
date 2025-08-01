//
//  TagHandler.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

protocol TagHandler {
	var nextHandler: (any TagHandler)? { get set }
	
	func processTag(_ tagName: String, text: String, withAttributes attributesDict: [String : String])
}
