//
//  CarouselViewController.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 25/08/21.
//

import UIKit

class CarouselViewController: UIViewController {
    
    @IBOutlet weak var breedCollection: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<String, DogBreed>! = nil
    var dogServices = DogServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        breedCollection.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        //1a. - create a section Provider
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            //1a. - 1.Item definition
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5)
            
            //1a. - 2.Group pdefinition
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalWidth(0.4))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0)
            
            //1a. - 3.Section definition
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 1, bottom: 10, trailing: 0)
            
            //1a. - 4.Supplementary view definition
            let globalHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
            let globalHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: globalHeaderSize, elementKind: "header", alignment: .top)
            // Set true or false depending on the desired behavior
            globalHeader.pinToVisibleBounds = true
            
            section.boundarySupplementaryItems = [globalHeader]
            
            return section
            
        }
        
        //1b. - create a compositional layout using this section provider
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    //MARK: - Data Source configuration
    
    private func updateImageConfiguration(item: DogBreed,
                                          completion: @escaping (Result<BreedConfiguration,
                                                                        Error>) -> Void)   {
        if let url = URL(string: item.image.url),
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            var configuration = BreedConfiguration.defaultCell()
            configuration.name = item.name
            configuration.image = image
            completion(.success(configuration))
        } else {
            completion(.failure(PresentingError.invalidImage))
        }
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BreedRow,DogBreed> (
            cellNib: UINib(nibName: "BreedRow",
                           bundle: nil))  { cell, indexPath, item in
            
            var configuration = BreedConfiguration.defaultCell()
            configuration.name = item.name
            cell.contentConfiguration = configuration
            
            DispatchQueue.global().async {
                self.updateImageConfiguration(item: item) { result in
                    if case let .success(configuration) = result  {
                        DispatchQueue.main.async {
                            cell.contentConfiguration = configuration
                        }
                    }
                }
            }

        }
        
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<HeaderCell>(supplementaryNib: UINib(nibName: "HeaderCell", bundle: nil), elementKind: "header") { (supplementaryView, sectionName, indexPath) in
            
            let identifiers = self.dataSource.snapshot().sectionIdentifiers
            let breedGroup = identifiers[indexPath.section]
            
            var configuration = HeaderConfiguration.defaultCell()
            configuration.title = breedGroup.isEmpty ? " " : breedGroup
            
            supplementaryView.contentConfiguration = configuration
        }
        
        dataSource = UICollectionViewDiffableDataSource<String, DogBreed>(collectionView: breedCollection) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: DogBreed) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: identifier)
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, index) in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<String, DogBreed>()
        snapshot.appendSections([])
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
}
