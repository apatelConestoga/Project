import UIKit

//************************ Two Sum ***********************************************
func twoSum(_ num1: Int, _ num2: Int) -> Double {
    return Double(num1 + num2)
}

print(twoSum(5, 10))


//*********************** Student Exists ************************************************
func studentExists(_ students: [String], _ name: String) -> Bool {
    return students.contains(name)
}

let students = ["Alice", "Bob", "Charlie", "David"]
print(studentExists(students, "Charlie"))


//************************ Reduce ***********************************************
func reduce(_ numbers: [Int]) -> Int {
    return numbers.reduce(0, +)
}

let numbers = [1, 2, 3, 4, 5]
print(reduce(numbers))


//************************ Pythagoras ***********************************************
func hypotenuse(_ a: Double, _ b: Double) -> Double {
    return sqrt(pow(a, 2) + pow(b, 2))
}

let c = hypotenuse(3.0, 4.0)
print("The length of the hypotenuse is \(c)")


//************************ Dictionary ***********************************************
func match(key: String, dictionary: [String: Any]) -> Any? {
    return dictionary[key]
}

let dictionaryValue: [String : Any] = ["name": "Kevin", "age": 25, "city": "Kitchener"]
if let matchedValue = match(key: "age", dictionary: dictionaryValue) {
    print("The value is: \(matchedValue)")
} else {
    print("Key not found in dictionary")
}

