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
    
    var dataSource: UICollectionViewDiffableDataSource<String, DogBreed>! = nil
    var dogServices = DogServices()
    
    //MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //3b. Data source usage - Updates the doog breed list
        dogServices.breedGroups { [self] result in
            if case let .success(breedGroups) = result {
                var snapshot = NSDiffableDataSourceSnapshot<String, DogBreed>()
                snapshot.appendSections(Array<String>(breedGroups.keys))
                for group in breedGroups.keys {
                    let breeds = breedGroups[group] ?? []
                    snapshot.appendItems(breeds, toSection: group)
                }
                OperationQueue.main.addOperation {
                    dataSource.apply(snapshot, animatingDifferences: false)
                }
            }
        }
    }
    
    //MARK: - Collection View layout
    
    private func configureHierarchy() {
        //1b. layout setup - defines the created list template as the collection view layout.
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        //1a. layout setup - Defines a plain list layout
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.headerMode = .supplementary
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    //MARK: - Data Source configuration
    
    private func configureDataSource() {
        
        //2a. - Cell registration
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, DogBreed> { (cell, indexPath, item) in
            var content = UIListContentConfiguration.cell()
            content.text = item.name
            cell.contentConfiguration = content
        }
        
        //2b. - Header registration
        let headerRegistration =
            
            UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind:"header") { (supplementaryView, kind, indexPath) in
                
                var content = UIListContentConfiguration.plainHeader()
            
                let identifiers = self.dataSource.snapshot().sectionIdentifiers
                let breedType = identifiers[indexPath.section]
            
                content.text = breedType.isEmpty ? " " : breedType
            
                supplementaryView.contentConfiguration = content
                
            }
        
        //2c. - Data Source setup
        dataSource = UICollectionViewDiffableDataSource<String, DogBreed>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: DogBreed) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: identifier)
        }
        //2d. - Sata Source supplementary view setup
        dataSource.supplementaryViewProvider = { (collectionView, kind, index) in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
        
        //3a. - Data source usage - Empty list setup
        let snapshot = NSDiffableDataSourceSnapshot<String, DogBreed>()
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
}

