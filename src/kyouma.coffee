H = require "./hououin"

class Search
  # Array
  @Sequential: (list, item) ->
    pos = 0
    found = false
    while pos < list.length and not found
      if list[pos] is item
        found = true
      else
        pos++
    found
  @OrderedSequential: (list, item) ->
    pos = 0
    found = false
    stop = false
    while pos < list.length and not found and not stop
      if list[pos] is item
        found = true
      else
        if list[pos] > item
          stop = true
        else
          pos++
    found
  @Binary: (list, item) ->
    first = 0
    last = list.length - 1
    found = false
    while first <= last and not found
      midpoint = (first + last) // 2
      if list[midpoint] is item
        found = true
      else
        if item < list[midpoint]
          last = midpoint - 1
        else
          first = midpoint + 1
    found
  # Graph
  @BreadthFirst: (graph, start) ->
    start.setDistance 0
    start.setPred null
    vertQueue = new Queue
    vertQueue.enqueue start
    until vertQueue.isEmpty()
      currentVert = vertQueue.dequeue()
      for nbr in currentVert.getConnections()
        if nbr.getColor() is "white"
          nbr.setColor "gray"
          nbr.setDistance(currentVert.getDistance() + 1)
          nbr.setPred currentVert
          vertQueue.enqueue nbr
      currentVert.setColor "black"

class Sort
  @Bubble: (list) ->
    for passNum in [list.length-1..0]
      for i in [0..passNum]
        if list[i] > list[i+1]
          temp = list[i]
          list[i] = list[i+1]
          list[i+1] = temp
  @ShortBubble: (list) ->
    passNum = list.length - 1
    exchanges = true
    while passNum > 0 and exchanges
      exhanges = false
      for i in [0..passNum]
        if list[i] > list[i+1]
          exchanges = true
          temp = list[i]
          list[i] = list[i+1]
          list[i+1] = temp
      passNum--
  @Selection: (list) ->
    for fillSlot in [list.length-1..0]
      maxPos = 0
      for pos in [0..fillSlot]
        if list[pos] > list[maxPos]
          maxPos = pos
      temp = list[fillSlot]
      list[fillSlot] = list[maxPos]
      list[maxPos] = temp
  @Insertion: (list) ->
    for i in [1..list.length-1]
      currentVal = list[i]
      pos = i
      while pos > 0 and list[pos-1] > currentVal
        list[pos] = list[pos-1]
        pos--
      list[pos] = currentVal
  @Shell: (list) ->
    gapInsertionSort = (list, start, gap) ->
      for i in [(start+gap)..list.length-1] by gap
        currentVal = list[i]
        pos = i
        while pos >= gap and list[pos - gap] > currentVal
          list[pos] = list[pos - gap]
          pos -= gap
        list[pos] = currentVal

    sublistCount = list.length // 2
    while sublistCount > 0
      for startPos in [0..sublistCount]
        gapInsertionSort list, startPos, sublistCount
      sublistCount = sublistCount // 2
  @Merge: (list) ->
    if list.length > 1
      mid = Math.ceil(list.length / 2)
      left = list[0...mid]
      right = list[mid..list.length-1]
      Sort.Merge left
      Sort.Merge right
      i = 0
      j = 0
      k = 0
      while i < left.length and j < right.length
        if left[i] <= right[i]
          list[k] = left[i]
          i++
        else
          list[k] = right[j]
          j++
        k++
      while i < left.length
        list[k] = left[i]
        i++
        k++
      while j < right.length
        list[k] = right[j]
        j++
        k++
  @Quick: (list) ->
    partition = (list, first, last) ->
      pivotVal = list[first]
      left = first + 1
      right = last
      done = false
      until done
        while left <= right and list[left] <= pivotVal
          left++
        while right >= left and list[right] >= pivotVal
          right--
        if right < left
          done = true
        else
          temp = list[left]
          list[left] = list[right]
          list[right] = temp
      temp = list[first]
      list[first] = list[right]
      list[right] = temp
      right

    quickRecurse = (list, first, last) ->
      if first < last
        splitPos = partition list, first, last
        quickRecurse list, first, splitPos-1
        quickRecurse list, splitPos+1, last

    quickRecurse list, 0, list.length-1

class Traversal
  @Preorder: (tree) ->
    if tree?
      console.log tree.getRootVal()
      Traversal.Preorder tree.getLeftChild()
      Traversal.Preorder tree.getRightChild()
  @Postorder: (tree) ->
    if tree?
      Traversal.Preorder tree.getLeftChild()
      Traversal.Preorder tree.getRightChild()
      console.log tree.getRootVal()
  @Inorder: (tree) ->
    if tree?
      Traversal.Preorder tree.getLeftChild()
      console.log tree.getRootVal()
      Traversal.Preorder tree.getRightChild()

# TODO Implement Dijkstra (shortest path) and Prim (minimum spanning tree)
