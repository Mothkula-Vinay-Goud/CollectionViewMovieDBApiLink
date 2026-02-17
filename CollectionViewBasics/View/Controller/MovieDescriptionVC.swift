//
//  MovieDescriptionVC.swift
//  CollectionViewBasics
//
//  Created by Vinay Goud Mothkula on 2/3/26.
//

import UIKit

class MovieDescriptionVC: UIViewController {

    var customImageView2: UIImageView?
    var movieTitle2: UILabel?
    var streamButton: UIButton?
    var movieInfoStack: UIStackView?
    var moviePopularityScore2: UILabel?
    var movieReleaseYear: UILabel?
    var movieRating: UILabel?
    var movieDescription: UILabel?
    var scrollView: UIScrollView!
    var contentView: UIView!

    var objMovieDescriptionVM: MovieDescriptionViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupUI()
        addSubviews()
        setupConstraints()
        configureData()
        
        
    }
    
    func setupScrollView() {
            scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollView)
            
            // Pin scrollView to edges
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            // Create a contentView inside the scrollView
            contentView = UIView()
            contentView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(contentView)
            
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                
                // Width must match scrollView for vertical scrolling
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        }

    func setupUI() {
        // MARK: Image
        customImageView2 = UIImageView()
//        customImageView2?.contentMode = .scaleAspectFill
//        customImageView2?.clipsToBounds = true
        customImageView2?.translatesAutoresizingMaskIntoConstraints = false

        // MARK: Title
        movieTitle2 = UILabel()
        movieTitle2?.textAlignment = .center
        movieTitle2?.font = .boldSystemFont(ofSize: 24)
        movieTitle2?.translatesAutoresizingMaskIntoConstraints = false

        // MARK: Stream Button
        streamButton = UIButton()
        streamButton?.setTitle("Watch Movie", for: .normal)
        streamButton?.backgroundColor = .systemBlue
        streamButton?.layer.cornerRadius = 10
        streamButton?.translatesAutoresizingMaskIntoConstraints = false

        // MARK: Row Labels
        moviePopularityScore2 = UILabel()
        moviePopularityScore2?.textAlignment = .center

        movieReleaseYear = UILabel()
        movieReleaseYear?.textAlignment = .center

        movieRating = UILabel()
        movieRating?.textAlignment = .center

        if let score = moviePopularityScore2, let year = movieReleaseYear, let rating = movieRating {
            movieInfoStack = UIStackView(arrangedSubviews: [score, year, rating])
            movieInfoStack?.axis = .horizontal
            movieInfoStack?.distribution = .fillEqually
            movieInfoStack?.translatesAutoresizingMaskIntoConstraints = false
        }

        // MARK: Description
        movieDescription = UILabel()
        movieDescription?.numberOfLines = 0
        movieDescription?.font = .systemFont(ofSize: 16)
        movieDescription?.translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews() {
        // All UI elements should be added to contentView, NOT view
        guard let contentView = contentView else { return }
        
        if let imageView = customImageView2 { contentView.addSubview(imageView) }
        if let title = movieTitle2 { contentView.addSubview(title) }
        if let button = streamButton { contentView.addSubview(button) }
        if let stack = movieInfoStack { contentView.addSubview(stack) }
        if let desc = movieDescription { contentView.addSubview(desc) }
    }

    func setupConstraints() {
        let spacing: CGFloat = 15

        guard
            let contentView = contentView,
            let imageView = customImageView2,
            let title = movieTitle2,
            let button = streamButton,
            let stack = movieInfoStack,
            let desc = movieDescription
        else { return }

        NSLayoutConstraint.activate([
            // Image
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350),

            // Title
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            // Stream Button
            button.topAnchor.constraint(equalTo: title.bottomAnchor, constant: spacing),
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 180),

            // Info Row
            stack.topAnchor.constraint(equalTo: button.bottomAnchor, constant: spacing),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stack.heightAnchor.constraint(equalToConstant: 20),

            // Description
            desc.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: spacing),
            desc.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            desc.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            desc.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20) // Important for scrolling
        ])
    }

    func configureData() {
        guard
            let movieTitle = objMovieDescriptionVM?.getTitle(),
            let movieScore = objMovieDescriptionVM?.getScore(),
            let movieYear = objMovieDescriptionVM?.getYear(),
            let movieRate = objMovieDescriptionVM?.getRating(),
            let movieDesc = objMovieDescriptionVM?.getDescription(),
            let movieImageName = objMovieDescriptionVM?.getImage()
        else { return }

        movieTitle2?.text = movieTitle
        let decimal = floor(movieScore * 100) / 100
        moviePopularityScore2?.text = "Score: \(decimal)"
        let str: String  = String(movieYear.prefix(4))
        movieReleaseYear?.text = "Year: \(str)"
        movieRating?.text = "Rating: \(movieRate)"
        movieDescription?.text = movieDesc
        customImageView2?.image = UIImage(named: movieImageName)
        let imagePath = Server.ImageBaseUrl.rawValue + movieImageName
        Task {
            await customImageView2?.loadImage(url: imagePath)
        }
    }
}
