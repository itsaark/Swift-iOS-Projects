//Insertion Sort
func insertionSort (array: [Int]) -> [Int] {
    
    var sortedArray = array
    
    for i in 1..<sortedArray.count {
        var counter = 1
        let x = sortedArray[i]
        var y = sortedArray[i-counter]
        var lastIndex = i
        
        if x < y  {
            
            lastIndex = i-counter
            
            while (i-counter) > -1 {
                if x < sortedArray[i-counter]{
                    
                    lastIndex = i-counter
                    y = sortedArray[i-counter]
                }
                counter += 1
            }
            sortedArray.remove(at: i)
            sortedArray.insert(x, at: lastIndex)
        }
        
    }
    
    
    return sortedArray
}


//Demo

let array = [9,3,4,2,90,87,5,4,3,65,6,8,3,1,0,7,8,-8,5,0]

insertionSort(array: array)