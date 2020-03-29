//
//  Search.swift
//  Playit
//
//  Created by Chad Parker on 2020-03-28.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import Foundation

struct Search: Codable {

    let kind: String
    let etag: String
    let regionCode: String

    let pageInfo: PageInfo
    struct PageInfo: Codable {

        let totalResults: Int
        let resultsPerPage: Int
    }

    let items: [Item]
    struct Item: Codable {

        let kind: String

        let id: Id
        struct Id: Codable {

            let kind: String
            let videoId: String?
            let channelId: String?
        }

        let snippet: YTSnippet
        struct YTSnippet: Codable {

            let title: String
            let channelTitle: String
            let publishedAt: Date
        }
    }
}
