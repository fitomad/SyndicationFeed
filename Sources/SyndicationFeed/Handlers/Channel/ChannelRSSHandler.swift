//
//  ChannelRSSHandler.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 29/7/25.
//

import Foundation

final class ChannelRSSHandler: TagHandler {
	private var details = ChannelRSSHandler.Details()
	private var categories = [String]()
	private var hours = [Int]()
	private var days = [SkipDays.Day]()
	
	var nextHandler: (any TagHandler)?
	
	func processTag(_ tagName: String, text: String, withAttributes attributesDict: [String : String]) {
		switch tagName {
			case RSS.Title.tagName:
				details.title = text
			case RSS.Description.tagName:
				details.description = text
			case RSS.Link.tagName:
				details.link = URL(string: text)
			case RSS.Language.tagName:
				details.language = text
			case RSS.Copyright.tagName:
				details.copyright = text
			case RSS.ManagingEditor.tagName:
				details.managingEditor = text
			case RSS.WebMaster.tagName:
				details.webMaster = text
			case RSS.PubDate.tagName:
				details.publishedAt = DateFormatter.publicationDateFormatter.date(from: text)
			case RSS.LastBuildDate.tagName:
				details.lastBuildAt = DateFormatter.publicationDateFormatter.date(from: text)
			case RSS.Category.tagName:
				categories.append(text)
			case RSS.Generator.tagName:
				details.generator = text
			case RSS.Docs.tagName:
				details.document = URL(string: text)
			case RSS.Cloud.tagName:
				let mapper = CloudMapper()
				if let cloud = try? mapper.mapToCloud(from: attributesDict) {
					details.cloud = cloud
				}
			case RSS.TTL.tagName:
				details.ttl = Int(text)
			case RSS.Rating.tagName:
				details.rating = text
			case RSS.SkipHours.Hour.tagName:
				if let hour = Int(text) {
					hours.append(hour)
				}
			case RSS.SkipDays.Day.tagName:
				if let day = SkipDays.Day(rawValue: text) {
					days.append(day)
				}
			default:
				nextHandler?.processTag(tagName, text: text, withAttributes: attributesDict)
		}
	}
}

extension ChannelRSSHandler {
	private struct Details {
		var title = ""
		var description: String?
		var link: URL?
		var language: String?
		var copyright: String?
		var managingEditor: String?
		var webMaster: String?
		var publishedAt: Date?
		var lastBuildAt: Date?
		var categories: [String]?
		var generator: String?
		var document: URL?
		var cloud: Cloud?
		var ttl: Int?
		var image: RSSImage?
		var rating: String?
		var skipHours: [Int]?
		var skipDays: SkipDays?	
	}
}

extension ChannelRSSHandler: ChannelTagHandler {
	func applyChanges(to channel: inout Channel) {
		channel.title = details.title
		channel.description = details.description
		channel.link = details.link
		channel.language = details.language
		channel.copyright = details.copyright
		channel.managingEditor = details.managingEditor
		channel.webMaster = details.webMaster
		channel.publishedAt = details.publishedAt
		channel.lastBuildAt = details.lastBuildAt
		channel.categories = details.categories
		channel.generator = details.generator
		channel.document = details.document
		channel.cloud = details.cloud
		channel.ttl = details.ttl
		channel.image = details.image
		channel.rating = details.rating
		channel.skipHours = hours
		channel.skipDays = SkipDays(days: days)
	}
}
