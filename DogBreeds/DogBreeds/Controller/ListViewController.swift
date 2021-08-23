//
//  ListViewController.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 23/08/21.
//

import UIKit


/// View Controller for a list (Table view like) collection view
class ListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section: String {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, DogBreed>! = nil
    var dogServices = DogServices()
    
    //MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Updates the doog breed list
        dogServices.breeds { result in
            if case let .success(breeds) = result {
                var snapshot = NSDiffableDataSourceSnapshot<Section, DogBreed>()
                snapshot.appendSections([.main])
                snapshot.appendItems(breeds, toSection: .main)
                //The data source update must be done in the main queue
                OperationQueue.main.addOperation {
                    self.dataSource.apply(snapshot, animatingDifferences: true)
                }
            }
        }
    }
    
    //MARK: - Collection View layout
    
    private func configureHierarchy() {
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        //Defines a plain list layout
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    //MARK: - Data Source configuration
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, DogBreed> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.name
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DogBreed>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: DogBreed) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: identifier)
        }
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, DogBreed>()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
}

