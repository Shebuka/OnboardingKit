//
//  PageView.swift
//  Athlee-Onboarding
//
//  Created by mac on 06/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit

public protocol Configurable {
    associatedtype Configuration
    func configure(_ configuration: Configuration)
}

public final class PageView: UIView {
    
    // MARK: Properties
    
    private let pageControlHeight: CGFloat = 34
    
    public var configuration: OnboardingConfiguration! { didSet { configure(configuration) } }
    
    fileprivate let topStackView = UIStackView()
    fileprivate let bottomStackView = UIStackView()
    
    public var image: UIImage = UIImage() { didSet { imageView.image = image } }
    public var pageTitle: String = "" { didSet { titleLabel.text = pageTitle } }
    public var pageDescription: String = "" { didSet { descriptionLabel.text = pageDescription } }
    
    public lazy var imageView = UIImageView()
    public lazy var titleLabel = UILabel()
    public lazy var descriptionLabel = UILabel()
    
    public var backgroundImage: UIImage = UIImage() { didSet { backgroundImageView.image = backgroundImage } }
    public var bottomBackgroundImage: UIImage = UIImage() { didSet { bottomBackgroundImageView.image = bottomBackgroundImage } }
    public var topBackgroundImage: UIImage = UIImage() { didSet { topBackgroundImageView.image = topBackgroundImage } }
    
    fileprivate var backgroundImageView = UIImageView()
    fileprivate var topBackgroundImageView = UIImageView()
    fileprivate var bottomBackgroundImageView = UIImageView()
    
    public var topContainerOffset: CGFloat = 8 {
        didSet {
            topContainerAnchor.constant = topContainerOffset
            topContainerHeightAnchor.constant = -topContainerOffset + offsetBetweenContainers
        }
    }
    public var bottomContainerOffset: CGFloat = 8 {
        didSet {
            bottomContainerAnchor.constant = bottomContainerOffset - pageControlHeight
            bottomContainerHeightAnchor.constant = -bottomContainerOffset - pageControlHeight - offsetBetweenContainers
        }
    }
    
    // Positive offset = more height for top container
    public var offsetBetweenContainers: CGFloat = 8 {
        didSet {
            topContainerHeightAnchor.constant = -topContainerOffset + offsetBetweenContainers
            bottomContainerHeightAnchor.constant = -bottomContainerOffset - pageControlHeight - offsetBetweenContainers
        }
    }
    
    fileprivate var topContainerAnchor: NSLayoutConstraint!
    fileprivate var bottomContainerAnchor: NSLayoutConstraint!
    fileprivate var topContainerHeightAnchor: NSLayoutConstraint!
    fileprivate var bottomContainerHeightAnchor: NSLayoutConstraint!
    
    // MARK: Life cycle
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    fileprivate func setup() {
        addSubview(topStackView)
        addSubview(bottomStackView)
        
        setupTopStackView()
        setupBottomStackView()
        addBackgroundImageViews()
    }
    
    fileprivate func addBackgroundImageViews() {
        setupBackgroundImageView()
        setupTopBackgroundImageView()
        setupBottomBackgroundImageView()
    }
    
    fileprivate func setupBackgroundImageView() {
        insertSubview(backgroundImageView, at: 0)
        
        backgroundImageView.isOpaque = true
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = backgroundImage
        
        let backgroundAnchors = [
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ].compactMap { $0 }
        NSLayoutConstraint.activate(backgroundAnchors)
    }
    
    fileprivate func setupTopBackgroundImageView() {
        insertSubview(topBackgroundImageView, at: 1)
        
        topBackgroundImageView.isOpaque = true
        topBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        topBackgroundImageView.contentMode = .scaleToFill
        topBackgroundImageView.image = topBackgroundImage
        
        let bottomBackgroundAnchors = [
            topBackgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBackgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBackgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            topBackgroundImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
            ].compactMap { $0 }
        NSLayoutConstraint.activate(bottomBackgroundAnchors)
    }
    
    fileprivate func setupBottomBackgroundImageView() {
        insertSubview(bottomBackgroundImageView, at: 1)
        
        bottomBackgroundImageView.isOpaque = true
        bottomBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomBackgroundImageView.contentMode = .scaleToFill
        bottomBackgroundImageView.image = bottomBackgroundImage
        
        let bottomBackgroundAnchors = [
            bottomBackgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBackgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBackgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomBackgroundImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
            ].compactMap { $0 }
        NSLayoutConstraint.activate(bottomBackgroundAnchors)
    }
    
    fileprivate func setupTopStackView() {
        // Top StackView layout setup
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        topContainerAnchor = topStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: topContainerOffset)
        topContainerHeightAnchor = topStackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5, constant: -topContainerOffset + offsetBetweenContainers)
        
        let topAnchors = [
            topStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 0),
            topStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: 0),
            topContainerAnchor,
            topContainerHeightAnchor
            ].compactMap { $0 }
        NSLayoutConstraint.activate(topAnchors)
        
        // StackViews common setup
        topStackView.axis = .vertical
        topStackView.alignment = .center
        topStackView.distribution = .fill
        topStackView.spacing = 0 // TODO: Make inspectable
        
        // Add subviews to the top StackView
        topStackView.addArrangedSubview(imageView)
        
        // Intial setup for top StackView subviews
        imageView.isOpaque = true
        imageView.contentMode = .scaleAspectFit
        
        // This way the StackView knows how to size & align subviews.
        imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .vertical)
    }
    
    fileprivate func setupBottomStackView() {
        // Bottom StackView layout setup
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomContainerAnchor = bottomStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -bottomContainerOffset - pageControlHeight)
        bottomContainerHeightAnchor = bottomStackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5, constant: -bottomContainerOffset - pageControlHeight - offsetBetweenContainers)
        
        let bottomAnchors = [
            bottomStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 0),
            bottomStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: 0),
            bottomContainerAnchor,
            bottomContainerHeightAnchor
            ].compactMap { $0 }
        NSLayoutConstraint.activate(bottomAnchors)
        
        // StackViews common setup
        bottomStackView.axis = .vertical
        bottomStackView.alignment = .center
        bottomStackView.distribution = .fill
        bottomStackView.spacing = 0 // TODO: Make inspectable
        
        // Add subviews to the bottom StackView
        bottomStackView.addArrangedSubview(titleLabel)
        bottomStackView.addArrangedSubview(descriptionLabel)
        
        // Intial setup for bottom StackView subviews
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        titleLabel.textAlignment = .center
        titleLabel.text = pageTitle
        //titleLabel.backgroundColor = .redColor()
        
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = pageDescription
        descriptionLabel.numberOfLines = 0
        //descriptionLabel.backgroundColor = .orangeColor()
        
        // This way the StackView knows how to size & align subviews.
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .vertical)
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .vertical)
    }
    
}

// MARK: - Configurable 

extension PageView: Configurable {
    public func configure(_ configuration: OnboardingConfiguration) {
        image = configuration.image
        pageTitle = configuration.pageTitle
        pageDescription = configuration.pageDescription
        
        if let backgroundImage = configuration.backgroundImage {
            self.backgroundImage = backgroundImage
        }
        
        if let bottomBackgroundImage = configuration.bottomBackgroundImage {
            self.bottomBackgroundImage = bottomBackgroundImage
        }
    }
}
