//
//  ProfileContentsCollectionViewCell.swift
//  TwitterLikeProfileView
//
//  Created by Teruki Nakano on 2018/10/12.
//  Copyright © 2018 Teruki Nakano. All rights reserved.
//

import UIKit

/*
ページング用のセル
*/

class ProfileContentsCollectionViewCell: UICollectionViewCell {

	static let nib = UINib(nibName: identifier, bundle: nil)
	static let identifier = "ProfileContentsCollectionViewCell"

    private var type: ProfileContentsViewController.ContentType = .tweet
    var contents: TweetViewController!

    override init(frame: CGRect) {
        super.init(frame: frame)
        contents = TweetViewController.instantiate()

        contentView.addSubview(contents.view)

        guard let view = contents.view else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	func configure(type: ProfileContentsViewController.ContentType) {
        
	}
}
