//
//  main.swift
//  Day1-Puzzle1
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import Elf
import NilCoalescingAssignmentOperators


//let inputFilename = "input.example"
let inputFilename = "input"
let inputURL = Bundle.main.url(forResource: inputFilename, withExtension: "")!
let inputContents = try! String(contentsOf: inputURL)
let inputLines = inputContents.components(separatedBy: .newlines)

var party = PartyOfElves()

var currentElf: Elf?
var elfLinesBuffer: [String] = []

var elfNameCounter = 1

for inputLine in inputLines {
	if !inputLine.isEmpty {
		elfLinesBuffer.append(inputLine)
	} else {
		createElf(fromLines: elfLinesBuffer)
		
		elfLinesBuffer = []
	}
}


func createElf(fromLines lines: [String])
{
	let foodItems = lines.map{ Int($0)! }.map{ FoodItem(calorieCountValue: $0) }
	
	party.add(
		elf: Elf(
			name: "Elf #\(elfNameCounter)",
			takingFoodPack: FoodPack(
				foodItems: foodItems
			)
		)
	)
	
	elfNameCounter += 1
}


for elf in party.elves {
	print("\(elf.name): \(elf.foodPack.totalCalorieCount.value) calories")
}

let foodPacks = party.elves.map{ $0.foodPack }
let calorieCountedFoodPacks = CalorieCountedFoodPacks(foodPacks: foodPacks, mostLimit: RecordCountLimit(value: 3), leastLimit: RecordCountLimit(value: 3))

let highestCalorieCountFoodPackEvles = party.elvesWithMostCaloriesInFoodPacks
print("Elves with highest calorie count in food pack: ")
for anElf in highestCalorieCountFoodPackEvles {
	print("\(anElf.foodPack.totalCalorieCount.value) calories")
}
let totalOfHighestCalorieCountFoodPacks = highestCalorieCountFoodPackEvles.map(\.foodPack.totalCalorieCount.value).reduce(0){ $0 + $1 }
print("Total: \(totalOfHighestCalorieCountFoodPacks)")

let lowestCalorieCountFoodPackElves = party.elvesWithLeastCaloriesInFoodPacks
print("Elves with lowest calorie count in food pack: ")
for anElf in lowestCalorieCountFoodPackElves {
	print("\(anElf.foodPack.totalCalorieCount.value) calories")
}
let totalOfLowestCalorieCountFoodPacks = lowestCalorieCountFoodPackElves.map(\.foodPack.totalCalorieCount.value).reduce(0){ $0 + $1 }
print("Total: \(totalOfLowestCalorieCountFoodPacks)")
