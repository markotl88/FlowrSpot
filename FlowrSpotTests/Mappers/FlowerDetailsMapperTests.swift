//
//  FlowerDetailsMapperTests.swift
//  FlowrSpotTests
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import XCTest
@testable import FlowrSpot

class FlowerDetailsMapperTests: XCTestCase {

      func testMapping() {
        let entity = FlowerDetailsDataMock().mockFlowerEntity()
        XCTAssertEqual(entity?.id, 2)
        XCTAssertEqual(entity?.name, "Lily")
        XCTAssertEqual(entity?.latinName, "Liliy in latin")
        XCTAssertEqual(entity?.sightings, 11)
        XCTAssertEqual(entity?.profilePicture, "//flowrspot.s3.amazonaws.com/flowers/profile_pictures/000/000/002/medium/dahlia-1627138_960_720.jpg?1519073382")
        XCTAssertEqual(entity?.features, [
          "Kingdom: Flower kingdom",
          "Height: 1cm"
        ])
        XCTAssertEqual(entity?.description, " vel urna vitae velit finibus lacinia. Etiam molestie nibh et orci ultricies tincidunt. Duis maximus, ipsum sit amet fringilla molestie, arcu nulla ultricies augue, eget placerat orci dui vel nisi. Vivamus nec interdum arcu. Pellentesque aliquam vitae enim sit amet condimentum. Sed ut accumsan eros. Nunc nec faucibus lacus. Pellentesque elementum nibh in sollicitudin facilisis. Proin at fringilla mauris. Curabitur non accumsan sapien. Maecenas tincidunt, dui at sagittis pulvinar, tortor ex molestie sapien, in facilisis risus ex id nisi. Nullam in quam erat")
        XCTAssertEqual(entity?.favorite, false)
      }
}
