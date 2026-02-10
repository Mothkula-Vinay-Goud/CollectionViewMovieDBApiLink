//
//  ViewController.swift
//  CollectionViewBasics
//
//  Created by Vinay Goud Mothkula on 2/3/26.
//

import UIKit

class MovieListVC: UIViewController {
//    MARK: Property
    lazy var objCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        // Temporary itemSize
        layout.itemSize = CGSize(width: 100, height: 100)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground

        // Register your cells
        collectionView.register(MovieFirstPageCell.self, forCellWithReuseIdentifier: "MovieFirstPageCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        return collectionView
    }()
    
    var obj : MovieListViewModelProtocol?
    
    init(obj: MovieListViewModelProtocol?) {
        super.init(nibName: nil, bundle: nil)
        self.obj = obj
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movies"
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        objCollectionView.delegate = self
        objCollectionView.dataSource = self
        
        //load mockdata
        Task{
            await obj?.getDataFromServer()
            objCollectionView.reloadData()
        }
        
        addSubviewsConstraints()
    }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()

            // Now the frame is known, calculate dynamic width
            if let layout = objCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                let columns: CGFloat = 2
                let spacing: CGFloat = 10
                let totalSpacing = (columns - 1) * spacing
                let width = (objCollectionView.frame.width - totalSpacing) / columns
                layout.itemSize = CGSize(width: width, height: width + width/2)
            }
        }
    //  MARK: Adding Subviews and Constraints
    func addSubviewsConstraints(){
        
            view.addSubview(objCollectionView)
            NSLayoutConstraint.activate([
                objCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                objCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                objCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                objCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                
                ])
    }
}
//  MARK: Delegate Methods
//  MARK: DataSouce Methods
extension MovieListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return obj?.getMoviesCount() ?? 0
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieFirstPageCell", for: indexPath) as! MovieFirstPageCell
            if let movie = obj?.getMovie(indexPath.row) {
                cell.setData(movieModel: movie)
            }
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .blue
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedMovie = obj?.getMovie(indexPath.row) else{return }
        let detailVC = MovieDescriptionVC()
    // Send data
        let viewModel = MovieDescriptionViewModel(selectedMovie: selectedMovie)
        detailVC.objMovieDescriptionVM = viewModel
    // Navigate
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

