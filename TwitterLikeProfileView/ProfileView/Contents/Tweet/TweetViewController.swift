//
//  TweetViewController.swift
//  TwitterLikeProfileView
//
//  Created by Teruki Nakano on 2018/10/17.
//  Copyright © 2018 Teruki Nakano. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, ProfileContentsScrollDelgate {

    var scrollView: UIScrollView {
        return tableView
    }

    @IBOutlet private weak var tableView: UITableView!

    static func instantiate() -> TweetViewController {
        let vc = UIStoryboard(name: "Tweet", bundle: nil).instantiateViewController(withIdentifier: "TweetViewController") as! TweetViewController
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension TweetViewController: UITableViewDelegate {}

extension TweetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)

        cell.textLabel?.text = "cell\(indexPath.row + 1)"

        return cell
    }
}

extension TweetViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == tableView, gestureRecognizer is UISwipeGestureRecognizer {
            return false
        }

        return true
    }
}
