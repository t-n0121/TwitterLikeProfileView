//
//  ProfileViewController.swift
//  TwitterLikeProfileView
//
//  Created by Teruki Nakano on 2018/10/12.
//  Copyright © 2018 Teruki Nakano. All rights reserved.
//

import UIKit

// TODO: scrollviewをProfileContentsViewControllerに置き換える
// scroll量をデリゲートなり何なりで受け取れるようにする

class ProfileViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet private weak var profileNavigationView: ProfileNavigationView!
    @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        profileNavigationView.delegate = self
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ProfileContentsViewController,
            segue.identifier == "EmbedSegue" {
            vc.delegate = self
        }
    }
}

extension ProfileViewController: ProfileContentsViewDelegate {

    // ナビゲーションのバックグラウンドのアルファ値の変更を始める境界のダミー
    // Twitterアプリだとユーザー名がナビゲーションにかかるタイミングで始まる
    private var dymmyBoundaryOfsetY: CGFloat {
        return 50
    }

    func updateScrollOffsetY(y: CGFloat) {
        print("updateScrollOfsetY: \(y)")
        updateNavigation(from: y)
        updateHeader(from: y)
    }

    func updateNavigation(from currentOfsetY: CGFloat) {
        let ofsetY = (currentOfsetY + 200) - dymmyBoundaryOfsetY
        profileNavigationView.setBackgroundAlpha(from: ofsetY)
    }

    func updateHeader(from currentOfsetY: CGFloat) {
        var constant = -(currentOfsetY + 200)

        if constant < -50 {
            constant = -50
        }

        headerViewTopConstraint.constant = constant
    }
}

extension ProfileViewController: ProfileNavigationViewDelegate {
    func didTapBackOrCloseButton() {
        navigationController?.popViewController(animated: true)
    }

    func didTapShareButton() {}
}
