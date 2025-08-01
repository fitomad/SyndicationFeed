//
//  ItemRSSHandler.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

final class ItemRSSHandler: TagHandler {
	private var details = ItemRSSHandler.Details()
	var nextHandler: (any TagHandler)?
	
	func processTag(_ tagName: String, text: String, withAttributes attributesDict: [String : String]) {
		switch tagName {
			case RSS.Title.tagName:
				details.title = text
			case RSS.Description.tagName:
				details.description = text
			case RSS.Link.tagName:
				details.link = URL(string: text)
			case RSS.Author.tagName:
				details.author = text
			case RSS.Category.tagName:
				details.categories?.append(text)
			case RSS.Comments.tagName:
				details.commentsURL = URL(string: text)
			case RSS.Enclosure.tagName:
				let mapper = EnclosureMapper()
				let enclosure = try? mapper.mapToEnclosure(from: attributesDict)
				details.enclosure = enclosure
			case RSS.GUID.tagName:
				let mapper = GUIDMapper()
				let guid = try? mapper.mapToGUID(from: attributesDict, urlContent: text)
				details.guid = guid
			case RSS.PubDate.tagName:
				details.publicationDate = DateFormatter.publicationDateFormatter.date(from: text)
			case RSS.Source.tagName:
				let mapper = SourceMapper()
				let source = try? mapper.mapToSource(from: attributesDict, text: text)
				details.source = source
			default:
				nextHandler?.processTag(tagName, text: text, withAttributes: attributesDict)
		}
	}
}

extension ItemRSSHandler {
	private struct Details {
		var title: String?
		var description: String?
		var link: URL?
		var author: String?
		var categories: [String]?
		var commentsURL: URL?
		var enclosure: Enclosure?
		var guid: Guid?
		var publicationDate: Date?
		var source: RSSSource?
	}
}

extension ItemRSSHandler: ItemTagHandler {
	func applyChanges(to item: inout Item) {
		item.title = details.title
		item.description = details.description
		item.link = details.link
		item.author = details.author
		item.categories = details.categories
		item.commentsURL = details.commentsURL
		item.enclosure = details.enclosure
		item.guid = details.guid
		item.publicationDate = details.publicationDate
		item.source = details.source
	}
}
