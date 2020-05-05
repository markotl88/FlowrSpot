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
extension FlowerDetailsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = row(at: indexPath) else {
          Logger.error("No availible row in dataSource at \(indexPath)")
          return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(SightingTableViewCell.self, at: indexPath)
        switch row {
        case let .sighting(entity):
          cell.setSighting(entity)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections()
    }
}

// MARK: - Private Methods
private extension FlowerDetailsDataSource {
  func buildSections() {
    let rows = sightings.map(SightingsRow.sighting)
    sections = [FlowerDetailsSection(rows: rows)]
  }
}
