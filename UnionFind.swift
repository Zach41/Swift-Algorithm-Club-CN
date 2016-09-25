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
