//
//  ViewController.swift
//  Playit
//
//  Created by Chad Parker on 2020-03-28.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let apiController = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()

        apiController.ytSearch("lowfi") { result in
            switch result {
            case .success(let searchResult):
                DispatchQueue.main.async {

                    print(searchResult.items.map { $0.id.videoId ?? "---" }.joined(separator: "\n"))
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    formatter.timeStyle = .short
                    print(searchResult.items.map { formatter.string(from: $0.snippet.publishedAt) }.joined(separator: "\n"))
                    dump(searchResult.pageInfo)

                }
            case .failure(let networkError):
                print("network error:")
                dump(networkError)
            }
        }
    }
}
