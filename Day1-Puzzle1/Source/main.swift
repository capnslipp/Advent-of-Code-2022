//
//  main.swift
//  Day1-Puzzle1
//
//  Created by Cap'n Slipp on 12/13/22.
//

import Foundation
import Elf



let elves = [
	Elf(
		name: "Elf #1",
		foodPack: FoodPack(
			foodItems: [
				FoodItem(calorieCount: CalorieCount(value: 1000)),
				FoodItem(calorieCount: CalorieCount(value: 2000)),
				FoodItem(calorieCount: CalorieCount(value: 3000)),
			]
		)
	),
	Elf(
		name: "Elf #2",
		foodPack: FoodPack(
			foodItems: [
				FoodItem(calorieCount: CalorieCount(value: 4000)),
			]
		)
	),
	Elf(
		name: "Elf #3",
		foodPack: FoodPack(
			foodItems: [
				FoodItem(calorieCount: CalorieCount(value: 5000)),
				FoodItem(calorieCount: CalorieCount(value: 6000)),
			]
		)
	),
	Elf(
		name: "Elf #4",
		foodPack: FoodPack(
			foodItems: [
				FoodItem(calorieCount: CalorieCount(value: 7000)),
				FoodItem(calorieCount: CalorieCount(value: 8000)),
				FoodItem(calorieCount: CalorieCount(value: 9000)),
			]
		)
	),
	Elf(
		name: "Elf #5",
		foodPack: FoodPack(
			foodItems: [
				FoodItem(calorieCount: CalorieCount(value: 10000)),
			]
		)
	),
]


for (elfI, elf) in elves.enumerated() {
	print("Elf #\(elfI + 1): \(elf.foodPack.totalCalorieCount.value) calories")
}
