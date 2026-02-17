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
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    let toggleButton: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = true
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    var objMovieListViewModel : MovieListViewModelProtocol?
    
    init(objMovieListViewModel: MovieListViewModelProtocol?) {
        super.init(nibName: nil, bundle: nil)
        self.objMovieListViewModel = objMovieListViewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
         
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        //load mockdata
        Task{
            await objMovieListViewModel?.getDataFromServer()
            objCollectionView.reloadData()
            activityIndicator.stopAnimating()
        }
        setUpUI()
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
    
    func setUpUI(){
        let title = UILabel()
        title.text = "Movies"
        title.font = UIFont.boldSystemFont(ofSize: 30)
        title.textAlignment = .center
        navigationItem.titleView = title
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Movies"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        toggleButton.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: toggleButton)
        
        view.backgroundColor = .white
        objCollectionView.delegate = self
        objCollectionView.dataSource = self
    }
    //  MARK: Adding Subviews and Constraints
    func addSubviewsConstraints(){
        
            view.addSubview(objCollectionView)
            view.addSubview(activityIndicator)
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
extension MovieListVC: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return objMovieListViewModel?.getMoviesCount() ?? 0
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieFirstPageCell", for: indexPath) as! MovieFirstPageCell
            if let movie = objMovieListViewModel?.getMovie(indexPath.row) {
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
        guard let selectedMovie = objMovieListViewModel?.getMovie(indexPath.row) else{return }
        let detailVC = MovieDescriptionVC()
    // Send data
        let viewModel = MovieDescriptionViewModel(selectedMovie: selectedMovie)
        detailVC.objMovieDescriptionVM = viewModel
    // Navigate
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        objMovieListViewModel?.filteredCountries(searchText: searchText)
        objCollectionView.reloadData()
    }
    //MARK: Toggle for Online/Offline Data
    @objc func toggleChanged(_ sender: UISwitch) {
        var service: NetworkManagerProtocol?
        
        if sender.isOn {
            service = NetworkManager()
        }else{
            service = MockNetworkManager()
        }
        objMovieListViewModel =  MovieListViewModel(service: service)
        
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        //load mockdata
        Task{
            await objMovieListViewModel?.getDataFromServer()
            objCollectionView.reloadData()
            activityIndicator.stopAnimating()
        }
    }
    

}

