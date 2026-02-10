//
//  MovieFirstPageCell.swift
//  CollectionViewBasics
//
//  Created by Vinay Goud Mothkula on 2/3/26.
//


import UIKit

class MovieFirstPageCell: UICollectionViewCell {
    //    MARK: Property
    var customImageView: UIImageView?
    var movieTitle: UILabel?
    var moviePopularityScore: UILabel?
    var movieReleaseYear: UILabel?
    var movieRating: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        movieTitle = UILabel()
        moviePopularityScore = UILabel()
        movieReleaseYear = UILabel()
        customImageView = UIImageView()
        movieRating = UILabel()
        addingAttributes()
        addSubviewConstraints()
    
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //Attributes
    func addingAttributes(){
        movieTitle?.textColor = .systemGreen
        movieTitle?.textAlignment = .center
        movieTitle?.translatesAutoresizingMaskIntoConstraints = false
        moviePopularityScore?.textColor = .black
        moviePopularityScore?.textAlignment = .center
        moviePopularityScore?.translatesAutoresizingMaskIntoConstraints = false
        movieReleaseYear?.textColor = .black
        movieReleaseYear?.textAlignment = .center
        movieReleaseYear?.translatesAutoresizingMaskIntoConstraints = false
        customImageView?.translatesAutoresizingMaskIntoConstraints = false
        movieRating?.textColor = .black
        movieRating?.textAlignment = .center
        movieRating?.translatesAutoresizingMaskIntoConstraints = false
    }
    //  MARK: Adding Subviews and Constraints
    func addSubviewConstraints(){
        if let movieTitle = movieTitle, let moviePopularityScore = moviePopularityScore, let movieReleaseYear = movieReleaseYear, let customImageView = customImageView, let movieRating = movieRating {
            contentView.addSubview(movieTitle)
            contentView.addSubview(moviePopularityScore)
            contentView.addSubview(movieReleaseYear)
            contentView.addSubview(customImageView)
            contentView.addSubview(movieRating)
            
            NSLayoutConstraint.activate([
                customImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                customImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
                customImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -contentView.bounds.height * 0.5),

    
                movieTitle.topAnchor.constraint(equalTo: customImageView.bottomAnchor, constant: 5),
                movieTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                movieTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
                moviePopularityScore.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 5),
                moviePopularityScore.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                moviePopularityScore.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
                movieReleaseYear.topAnchor.constraint(equalTo: moviePopularityScore.bottomAnchor, constant: 5),
                movieReleaseYear.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                movieReleaseYear.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
                movieRating.topAnchor.constraint(equalTo: movieReleaseYear.bottomAnchor, constant: 5),
                movieRating.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                movieRating.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ])
        }
    }
    //adding data to the properties
    func setData(movieModel:MovieModel){
        movieTitle?.text = "Title: \(movieModel.title ?? "No Title")"
        moviePopularityScore?.text = "Score : \(movieModel.popularity ?? 0)"
       movieReleaseYear?.text =   "Year : \(movieModel.release_date ?? "No Year")"
        movieRating?.text = "Rating : \(movieModel.vote_average ?? 0)"
        customImageView?.image = UIImage(named: "\(movieModel.poster_path ?? "No Image")")
        let imagePath = Server.ImageBaseUrl.rawValue + (movieModel.poster_path ?? "")
                Task {
                        await customImageView?.loadImage(url: imagePath)
                }


    }
}
