//
//  ImageParser.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 15/10/24.
//

import Foundation

final class ImageParser: NSObject {
	private var image: RSSImage?
	private var size: RSSImage.Size?
	
	private var currentCharacters = ""
	private var actualElement = ""
	
	private var linkContent = ""
	private var urlContent = ""
	private var imageDescription = ""
	private var imageTitle = ""
	
	weak var delegate: ImageParserDelegate?
	
	private let rootXMLDelegate: XMLParserDelegate
	private weak var rootParser: XMLParser?
	
	init(rootXMLDelegate: XMLParserDelegate, rootParser: XMLParser) {
		self.rootXMLDelegate = rootXMLDelegate
		self.rootParser = rootParser
	}
	
	private func buildImage() throws(SyndicationFeedError) {
		guard let url = URL(string: urlContent) else {
			throw .malformedAttributeValue(urlContent,
										   attribute: RSS.Image.AttributeKeys.url.rawValue,
										   tag: RSS.Image.tagName)
		}
		
		guard let link = URL(string: linkContent) else {
			throw .malformedAttributeValue(linkContent,
										   attribute: RSS.Image.AttributeKeys.link.rawValue,
										   tag: RSS.Image.tagName)
		}
		
		image = RSSImage(title: imageTitle,
						 url: url,
						 link: link)
		
		image?.description = imageDescription
		
		if let size {
			image?.size = size
		}
	}
}

extension ImageParser: Restorable {
	func restoreParserDelegate() {
		rootParser?.delegate = rootXMLDelegate
	}
}

extension ImageParser: XMLParserDelegate {
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
		currentCharacters = ""
		actualElement = elementName
	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		switch elementName {
			case RSS.Image.AttributeKeys.width.rawValue:
				size = size ?? RSSImage.Size()
				size?.width = Int(currentCharacters) ?? 0
			case RSS.Image.AttributeKeys.height.rawValue:
				size = size ?? RSSImage.Size()
				size?.height = Int(currentCharacters) ?? 0
			case RSS.Image.tagName:
				do {
					try buildImage()
					
					if let image {
						delegate?.imageParser(self, didFinishParse: image)
					} else {
						delegate?.imageParser(self, didFailWithError: .malformedContent)
					}
					
					restoreParserDelegate()
				} catch {
					delegate?.imageParser(self, didFailWithError: error)
					restoreParserDelegate()
				}
			default:
				break;
		}
	}
	
	func parser(_ parser: XMLParser, foundCharacters string: String) {
		currentCharacters.append(string)
		
		switch actualElement {
			case RSS.Image.AttributeKeys.url.rawValue:
				urlContent.append(string)
			case RSS.Image.AttributeKeys.title.rawValue:
				imageTitle.append(string)
			case RSS.Image.AttributeKeys.link.rawValue:
				linkContent.append(string)
			case RSS.Image.AttributeKeys.description.rawValue:
				imageDescription.append(string)
			default:
				break
		}
	}
}
