//
//  ProfileViewController.swift
//  TwitterLikeProfileView
//
//  Created by Teruki Nakano on 2018/10/12.
//  Copyright © 2018 Teruki Nakano. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var profileNavigationView: ProfileNavigationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        profileNavigationView.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileViewController: UIScrollViewDelegate {

    // ナビゲーションのバックグラウンドのアルファ値の変更を始める境界のダミー
    // Twitterアプリだとユーザー名がナビゲーションにかかるタイミングで始まる
    private var dymmyBoundaryOfsetY: CGFloat {
        return 200
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateNavigation(from: scrollView.contentOffset.y)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateNavigation(from: scrollView.contentOffset.y)
    }

    func updateNavigation(from currentOfsetY: CGFloat) {
        let ofsetY = currentOfsetY - dymmyBoundaryOfsetY
        profileNavigationView.setBackgroundAlpha(from: ofsetY)
    }
}

extension ProfileViewController: ProfileNavigationViewDelegate {
    func didTapBackOrCloseButton() {
        navigationController?.popViewController(animated: true)
    }

    func didTapShareButton() {}
}
