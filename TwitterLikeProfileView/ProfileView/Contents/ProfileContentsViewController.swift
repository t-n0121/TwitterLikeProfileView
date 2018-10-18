//
//  ProfileViewController.swift
//  TwitterLikeProfileView
//
//  Created by Teruki Nakano on 2018/10/17.
//  Copyright © 2018 Teruki Nakano. All rights reserved.
//

import UIKit

protocol ProfileContentsScrollDelgate {
    var scrollView: UIScrollView { get }
}

protocol ProfileContentsViewDelegate {
    func updateScrollOffsetY(y: CGFloat)
}

class ProfileContentsViewController: UIViewController {

    enum ContentType: Int {
		case tweet
		case tweetAndReply
        case media
        case like
	}

	@IBOutlet weak var collectionView: UICollectionView!

	var type: ContentType = .tweet
    var delegate: ProfileContentsViewDelegate? = nil

    private var currentOffsetY: CGFloat = -300 {
        didSet {
            delegate?.updateScrollOffsetY(y: currentOffsetY)

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.register(ProfileContentsCollectionViewCell.nib, forCellWithReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ProfileContentsViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return collectionView.bounds.size
	}
}

extension ProfileContentsViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProfileContentsCollectionViewCell
        cell.configure(type: ContentType(rawValue: indexPath.row)!)
        cell.contents.scrollView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 64, right: 0)
		return cell
	}

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if let _cell = cell as? ProfileContentsCollectionViewCell {
            _cell.contents.scrollView.delegate = self
            updateScrollOffsetY(scrollView: _cell.contents.scrollView)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if let _cell = cell as? ProfileContentsCollectionViewCell {
            _cell.contents.scrollView.delegate = nil
        }
    }

    func updateScrollOffsetY(scrollView: UIScrollView) {
        // case1
        // 現在の画面のヘッダーが隠れている場合かつ次に表示する画面のヘッダーが見えている場合
        // ヘッダーが隠れている状態にする
        // リストの開始位置はセグメントUIの下が1番目になる
        if currentOffsetY > -150,  scrollView.contentOffset.y <= -150 {
            scrollView.contentOffset.y = -150
            delegate?.updateScrollOffsetY(y: -150)
        }
            // case2
            // 現在の画面のヘッダーが見えている場合
            // 次の画面のオフセットの位置を同じにする
        else if currentOffsetY <= -150 {
            scrollView.contentOffset.y = currentOffsetY
            delegate?.updateScrollOffsetY(y: currentOffsetY)
        } else {

        }
    }
}

extension ProfileContentsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView { return }
        currentOffsetY = scrollView.contentOffset.y
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView { return }
        currentOffsetY = scrollView.contentOffset.y
    }
}
