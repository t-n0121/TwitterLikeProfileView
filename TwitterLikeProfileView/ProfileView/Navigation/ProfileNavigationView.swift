//
//  ProfileNavigationView.swift
//  TwitterLikeProfileView
//
//  Created by Teruki Nakano on 2018/10/12.
//  Copyright © 2018 Teruki Nakano. All rights reserved.
//

import UIKit

protocol ProfileNavigationViewDelegate {
    func didTapBackOrCloseButton()
    func didTapShareButton()
}

@IBDesignable
class ProfileNavigationView: UIView {

    @IBOutlet private(set) weak var _view: UIView! {
        didSet {
            addSubview(_view)
            _view.translatesAutoresizingMaskIntoConstraints = false
            _view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            _view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            _view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            _view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
    }
    @IBOutlet weak var backOrCloseButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!


    @IBAction func backOrCloseButtonTapped() {
        delegate?.didTapBackOrCloseButton()
    }

    @IBAction func shareButtonTapped() {
        delegate?.didTapShareButton()
    }

    class var nibName: String {
        return String(describing: self)
    }

    @IBInspectable
    var title: String? {
        didSet {
            nameLabel.text = title
        }
    }

    @IBInspectable
    var backgorundAlpha: CGFloat = 1 {
        didSet {
            backGroundView.alpha = backgorundAlpha
        }
    }

    var delegate: ProfileNavigationViewDelegate? = nil

    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        configure()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        configure()
    }
}

extension ProfileNavigationView {

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        if let name = nameLabel.text {
            let attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key(kCTLanguageAttributeName as String): "ja",
                ]

            nameLabel?.attributedText = NSAttributedString(string: name, attributes: attributes)
        }
    }

    private func loadNib() {
        UINib(nibName: type(of: self).nibName, bundle: nil)
            .instantiate(withOwner: self, options: nil)
    }

    private func configure() {
        backOrCloseButton.setImage(#imageLiteral(resourceName: "nav_back"), for: .normal)
        shareButton.setImage(#imageLiteral(resourceName: "nav_share"), for: .normal)
    }
}


extension ProfileNavigationView {
    func setBackgroundAlpha(from ofsetY: CGFloat) {
        if ofsetY >= 0 {
            backgorundAlpha = CGFloat(ofsetY / bounds.height)
        } else {
            backgorundAlpha = 0
        }
    }
}
