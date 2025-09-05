# SyndicationFeed

**SyndicationFeed** is a comprehensive Swift package designed to parse RSS feeds with a focus on podcast content, including full support for the [Podcast Index RSS 2.0 specification](https://podcastindex.org/podcast-rss-specification). Whether you're building a podcast app, analyzing RSS feeds, or working with modern podcasting features, this package provides a robust, type-safe, and async-first approach to feed parsing.

Built with clarity and extensibility in mind, **SyndicationFeed** handles standard RSS elements alongside advanced podcast-specific tags like `<podcast:transcript>`, `<podcast:chapters>`, `<podcast:value>`, and other innovative features of the evolving RSS 2.0 spec.

## ✨ Features

- 🧠 **Simple async API** for parsing RSS feeds from URLs, strings, or data
- 💡 **Codable-based models** for seamless Swift integration
- 📡 **Multi-namespace support** including RSS 2.0, iTunes/Apple Podcasts, and Podcasting 2.0
- 🔧 **Comprehensive tag support** for modern podcast features
- 🧪 **Built-in validation** and detailed error handling
- ⚡ **Performance optimized** with streaming XML parsing
- 🛡️ **Type-safe** Swift models for all feed elements
- 📱 **Platform support** for macOS 13.0+

## 🚀 Quick Start

### Installation

Add SyndicationFeed to your Swift package dependencies in `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/fitomad/SyndicationFeed.git", from: "0.9.0")
]
```

Or add it through Xcode's Package Manager by entering the repository URL.

### Basic Usage

```swift
import SyndicationFeed

let syndicationFeed = SyndicationFeed()

// Parse from URL
do {
    let url = URL(string: "https://example.com/podcast.xml")!
    let result = try await syndicationFeed.fetchFeedFrom(url: url)
    
    let channel = result.channel
    print("Podcast: \(channel.title)")
    print("Episodes: \(channel.items.count)")
    
    // Access podcast-specific data
    if let podcastInfo = channel.podcasting {
        print("GUID: \(podcastInfo.guid?.uuidString ?? "N/A")")
        print("Medium: \(podcastInfo.medium?.rawValue ?? "N/A")")
    }
    
} catch let error as SyndicationFeedError {
    print("Parsing error: \(error)")
}
```

### Parse from String Content

```swift
let xmlContent = """
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:podcast="https://podcastindex.org/namespace/1.0">
    <channel>
        <title>My Podcast</title>
        <description>A great podcast</description>
        <!-- ... more content ... -->
    </channel>
</rss>
"""

do {
    let result = try await syndicationFeed.fetchFeedFrom(content: xmlContent)
    let channel = result.channel
    // Process the parsed feed...
} catch {
    print("Error: \(error)")
}
```

### Parse from Data

```swift
let feedData = // ... your RSS feed data
let result = try await syndicationFeed.fetchFeedFrom(data: feedData)
```

## 📊 Supported Features

### RSS 2.0 Standard Elements
- **Channel**: title, description, link, language, copyright, etc.
- **Items**: title, description, publication date, enclosures, etc.
- **Media**: enclosures with full metadata support
- **Categories**: hierarchical category support

### iTunes/Apple Podcasts Namespace
- **Channel metadata**: author, categories, explicit content flags
- **Episode data**: duration, episode numbers, season numbers
- **Content classification**: episode types, explicit content markers
- **Images**: high-resolution artwork support

### Podcasting 2.0 Namespace
- **Identity**: GUID, locked status
- **Rich media**: alternate enclosures, chapters, transcripts
- **Monetization**: value blocks, funding information
- **Social features**: person tags, social interaction
- **Discovery**: trailers, seasons, episodes
- **Live content**: live item support
- **Location data**: geographic information
- **Content links**: web-based content references

## 🏗️ Architecture

The package is built with a clean, modular architecture:

```
SyndicationFeed/
├── Entities/           # Data models
│   ├── RSS/           # Standard RSS elements
│   ├── Apple/         # iTunes/Apple Podcasts elements  
│   └── Podcast/       # Podcasting 2.0 elements
├── Parsers/           # XML parsing logic
├── Handlers/          # Tag-specific parsing handlers
├── Mappers/           # Data transformation utilities
└── Extensions/        # Utility extensions
```

### Core Types

#### `FeedResult`
The main result type containing the parsed channel and any parsing errors:

```swift
public struct FeedResult {
    public let channel: Channel
    public let parsingErrors: [SyndicationFeedError]?
}
```

#### `Channel`
Represents the main podcast/feed information:

```swift
public struct Channel {
    public var title: String
    public var description: String?
    public var items: [Item]    // Episodes
    public var podcasting: Podcasting?  // Podcasting 2.0 data
    public var iTunes: Apple?           // iTunes/Apple data
    // ... other RSS properties
}
```

#### `Item`
Represents individual episodes or items:

```swift
public struct Item {
    public var title: String?
    public var description: String?
    public var enclosure: Enclosure?
    public var podcasting: Podcasting? // Episode-specific podcast data
    public var iTunes: Apple?          // iTunes episode data
    // ... other properties
}
```

## 🔧 Advanced Usage

### Error Handling

SyndicationFeed provides detailed error information through the `SyndicationFeedError` enum:

```swift
do {
    let result = try await syndicationFeed.fetchFeedFrom(url: feedURL)
    
    // Check for parsing warnings
    if let errors = result.parsingErrors {
        for error in errors {
            switch error {
            case .unavailableTag(let tagName, let element):
                print("Unknown tag '\(tagName)' in '\(element)'")
            case .malformedTagValue(let value, let tag):
                print("Invalid value '\(value)' for tag '\(tag)'")
            // Handle other error types...
            default:
                print("Parsing warning: \(error)")
            }
        }
    }
    
} catch SyndicationFeedError.contentNotFound {
    print("Feed content not found or inaccessible")
} catch SyndicationFeedError.malformedContent {
    print("Feed content is malformed or invalid XML")
} catch {
    print("Unexpected error: \(error)")
}
```

### Working with Podcasting 2.0 Features

```swift
let result = try await syndicationFeed.fetchFeedFrom(url: podcastURL)
let channel = result.channel

// Check if this is a locked podcast
if let locked = channel.podcasting?.locked {
    print("Podcast is locked by: \(locked.owner)")
}

// Access value/payment information
if let values = channel.podcasting?.values {
    for value in values {
        print("Payment method: \(value.method)")
        print("Recipient: \(value.address)")
        print("Split: \(value.split)%")
    }
}

// Process episodes with transcripts
for item in channel.items {
    if let transcripts = item.podcasting?.transcripts {
        for transcript in transcripts {
            print("Transcript available at: \(transcript.url)")
            print("Language: \(transcript.language ?? "unknown")")
        }
    }
}
```

## 🧪 Testing

The package includes comprehensive tests with sample RSS feeds:

```bash
swift test
```

Test resources include:
- iTunes-compatible feeds
- Podcasting 2.0 example feeds
- Various RSS versions (0.91, 0.92, 2.0)
- Edge case scenarios

## 📋 Requirements

- **Swift**: 6.0+
- **Platform**: macOS 13.0+
- **Dependencies**: Foundation only (no external dependencies)

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Podcast Index](https://podcastindex.org/) for the Podcasting 2.0 namespace specification
- Apple for the iTunes podcast specification
- The RSS specification maintainers

## Version history

### 0.9.3

- The `SyndicationFeedService` protocol renamed to `SyndicationFeedProvider`
- Fetch RSS feed using an URL now uses the `URLSession` `data` function instead of the `Data` intializer

### 0.9.0

- Support for...
	- RSS
	- iTunes
	- Podcasting 2.0

## Contact

- BlueSky [@fitomad.bsky.social](https://bsky.app/profile/fitomad.bsky.social)
- Mastodon [@fitomad](https://mastodon.social/@fitomad)
- LinkedIn [Adolfo Vera](https://www.linkedin.com/in/adolfo-vera/)

---

Let your Swift code speak fluent podcast. 🎙️
