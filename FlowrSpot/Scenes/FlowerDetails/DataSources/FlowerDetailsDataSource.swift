//
//  FlowerDetailsDataSource.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 01/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import PovioKit

class FlowerDetailsDataSource: NSObject, DataSource {
  var sections = [FlowerDetailsSection]()
  private var sightings = [Sighting]()
  
  func update(sightings: [Sighting]) {
    self.sightings = sightings
    buildSections()
  }
}

// MARK: - UICollectionView DataSource
extension FlowerDetailsDataSource: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return numberOfSections()
  }
      
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return numberOfRows(in: section)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let row = row(at: indexPath) else {
      Logger.error("No availible row in dataSource at \(indexPath)")
      return UICollectionViewCell()
    }
    
    let cell = collectionView.dequeueReusableCell(SightingCollectionViewCell.self, at: indexPath)
    switch row {
    case let .sighting(entity):
      cell.setSighting(entity)
    }
    return cell
  }
}

// MARK: - Private Methods
private extension FlowerDetailsDataSource {
  func buildSections() {
    let rows = sightings.map(SightingsRow.sighting)
    sections = [FlowerDetailsSection(rows: rows)]
  }
}
