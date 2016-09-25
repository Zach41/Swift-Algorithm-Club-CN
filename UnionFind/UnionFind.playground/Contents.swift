//: Playground - noun: a place where people can play

struct UnionFind<T: Hashable> {
    private var index = [T : Int]()
    private var parent = [Int]()        // parent[i] is the parent's index of node i
    private var size = [Int]()          // size[i] is the size of set i
    
    mutating func addSetWith(_ element: T) {
        index[element] = parent.count
        parent.append(parent.count)     // parent[i] = i indicates that node i is the root node
        size.append(1)
    }
    
    mutating func setOf(_ element: T) -> Int? {
        if let indexOfElement = index[element] {
            return setByIndex(indexOfElement)
        } else {
            return nil
        }
    }
    
    mutating func unionSetsContaining(_ firstElement: T, and secondElement: T) {
        if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
            if firstSet != secondSet {
                if size[firstSet] > size[secondSet] {
                    parent[secondSet] = firstSet
                    size[firstSet] += size[secondSet]
                } else {
                    parent[firstSet] = secondSet
                    size[secondSet] += size[firstSet]
                }
            }
        }
    }
    
    mutating func inSameSet(_ firstElement: T, and secondElement: T) -> Bool {
        if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
            return firstSet == secondSet
        } else {
            return false
        }
    }
    
    private mutating func setByIndex(_ index: Int) -> Int {
        if parent[index] == index {
            return index
        } else {
            parent[index] = setByIndex(parent[index])
            return parent[index]
        }
    }
}

// Testing

var dsuInt = UnionFind<Int>()

for i in 1...10 {
    dsuInt.addSetWith(i)
}

for i in 3...10 {
    if i % 2 == 0 {
        dsuInt.unionSetsContaining(2, and: i)
    } else {
        dsuInt.unionSetsContaining(1, and: i)
    }
}

for i in stride(from: 1, through: 7, by: 2) {
    print(dsuInt.inSameSet(i, and: i+2))
}

for i in stride(from: 2, to: 8, by: 2) {
    print(dsuInt.inSameSet(i, and: i+2))
}

print(dsuInt.inSameSet(1, and: 2))
print(dsuInt.inSameSet(3, and: 8))

var dsuString = UnionFind<String>()

let words = ["all", "burden", "after", "awesome", "boy", "bye"]

dsuString.addSetWith("a")
dsuString.addSetWith("b")

for word in words {
    dsuString.addSetWith(word)
    if word.hasPrefix("a") {
        dsuString.unionSetsContaining("a", and: word)
    } else {
        dsuString.unionSetsContaining("b", and: word)
    }
}

print(dsuString.inSameSet("a", and: "all"))
print(dsuString.inSameSet("all", and: "after"))
print(dsuString.inSameSet("after", and: "awesome"))
print(dsuString.inSameSet("b", and: "burden"))
print(dsuString.inSameSet("burden", and: "boy"))
print(dsuString.inSameSet("boy", and: "bye"))

print(dsuString.inSameSet("b", and: "a"))
print(dsuString.inSameSet("after", and: "bye"))