//
//  ImageParser.swift
//  PodcastFeed
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
	
	private func buildImage() throws(ImageParser.Failure) {
		guard let url = URL(string: urlContent) else {
			throw ImageParser.Failure.malformedURL(field: "url", content: urlContent)
		}
		
		guard let link = URL(string: linkContent) else {
			throw ImageParser.Failure.malformedURL(field: "url", content: urlContent)
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
						delegate?.imageParser(self, didFailWithError: .invalidImage)
					}
				} catch {
					delegate?.imageParser(self, didFailWithError: error)
				}
			default:
				break;
		}
	}
	
	func parser(_ parser: XMLParser, foundCharacters string: String) {
		currentCharacters.append(string)
		
		switch actualElement {
			case Tags.url:
				urlContent.append(string)
			case Tags.title:
				imageTitle.append(string)
			case Tags.link:
				linkContent.append(string)
			case Tags.description:
				imageDescription.append(string)
			default:
				break
		}
	}
	
	func parser(_ parser: XMLParser, parseErrorOccurred parseError: any Error) {
		print("🚨 \(parseError)")
	}
}

extension ImageParser {
	enum Tags {
		static let image = "image"
		static let url = "url"
		static let title = "title"
		static let link = "link"
		static let description = "description"
		static let width = "width"
		static let height = "height"
	}
}

extension ImageParser {
	enum Failure: Error {
		case malformedURL(field: String, content: String)
		case invalidImage
	}
}
