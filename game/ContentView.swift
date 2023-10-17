//
//  ContentView.swift
//  game
//
//  Created by Student Account on 10/16/23.
//

import SwiftUI

struct Point: Identifiable, Equatable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    
    static func ==(lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

struct GridView: View {
    @State var points: [Point] = [
        Point(x: 0, y: 0),
        Point(x: 1, y: 0),
        Point(x: 2, y: 0),
        Point(x: 0, y: 1),
        Point(x: 1, y: 1),
        Point(x: 2, y: 1),
        Point(x: 0, y: 2),
        Point(x: 1, y: 2)
    ]
    
    @State private var emptyPoint = Point(x: 2, y: 2)
    init() {
        _points = State(initialValue: points.shuffled())
    }
    
    func isAdjacent(point: Point, to empty: Point) -> Bool {
        let dx = abs(point.x - empty.x)
        let dy = abs(point.y - empty.y)
        
        return (dx == 1 && dy == 0) || (dx == 0 && dy == 1)
    }
    
    var body: some View {
        let shuffledLabels = Array(1...8).shuffled()
        
        return VStack(spacing: 10) {
            ForEach(0..<3) { row in
                HStack(spacing: 10) {
                    ForEach(0..<3) { col in
                        let index = row * 3 + col
                        if index < points.count {
                            let point = points[index]
                            Button(action: {
                                if isAdjacent(point: point, to: emptyPoint) {
                                    withAnimation {
                                        let temp = points[index]
                                        points[index] = emptyPoint
                                        emptyPoint = temp
                                    }
                                }
                            }) {
                                Text("\(shuffledLabels[index])")
                                    .frame(width: 50, height: 50)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                            .position(x: points[index].x * 60 + 25, y: points[index].y * 60 + 25) // added +25 to center the buttons
                        }
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        GridView()
            .padding()
    }
}



