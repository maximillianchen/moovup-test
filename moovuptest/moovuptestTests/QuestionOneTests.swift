//
//  QuestionOneTests.swift
//  moovuptestTests
//
//  Created by Max on 16/9/2024.
//

import XCTest

final class QuestionOneTests: XCTestCase {

    let graphNodes: [String: [String]] = [
        "A": ["B", "D", "H"],
        "B": ["A", "C", "D"],
        "C": ["B", "D", "F"],
        "D": ["A", "B", "C", "E"],
        "E": ["D", "F", "H"],
        "F": ["C", "E", "G"],
        "G": ["F", "H"],
        "H": ["A", "E", "G"]
    ]
    
    func allPaths(
        first: String,
        last: String,
        path: [String] = [],
        visited: [String] = []
    ) -> [[String]] {
        
        var path = path
        var visited = visited
        path.append(first)
        visited.append(first)
        
        if first == last { return [path] }
        
        var possiblePaths: [[String]] = []
        if let nodeOption = graphNodes[first] {
            nodeOption.forEach { node in
                if !visited.contains(node) {
                    let newPaths = allPaths(first: node, last: last, path: path, visited: visited)
                    possiblePaths.append(contentsOf: newPaths)
                }
            }
        }

        return possiblePaths
    }
    
    func shortestPath(first: String, last: String) -> [String] {
        var possiblePaths = [[String]]()
        var visited = [String]()
        
        possiblePaths.append([first])
        visited.append(first)
        
        while !possiblePaths.isEmpty {
            // print("possiblePaths__ \(possiblePaths)")
            var path = possiblePaths.removeFirst()
            // print("path__ \(path)")
            if let lastNode = path.last {
                if let nodeOption = graphNodes[lastNode] {
                    for node in nodeOption {
                        if !visited.contains(node) {
                            if let lastNode = nodeOption.first(where: { $0 == last }) {
                                // the shortest path
                                path.append(lastNode)
                                return path
                            } else {
                                var newPath = path
                                newPath.append(node)
                                possiblePaths.append(newPath)
                                
                            }
                            visited.append(node)
                        }
                    }
                }
            }
        }
        
        // No found
        return []
    }

    func testQuestionOne() throws {
        
        let allPossiblePaths = allPaths(first: "A", last: "H")
        print("allPossiblePaths: \(allPossiblePaths)")
        print("paths count: \(allPossiblePaths.count)")
        
        let shortestPath = shortestPath(first: "A", last: "H")
        print("shortestPath: \(shortestPath)")
        
    }

}
