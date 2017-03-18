module.exports = {
  createLinkedListQueue() {
    let length = 0
    let head = undefined
    let tail = undefined
    return {
      enqueue(value) {
        enqueueNode(value)
      },
      dequeue() {
        return dequeueNode()
      },
      size() {
        return length
      },
      head() {
        return head
      },
      tail() {
        return tail
      }
    }
    function enqueueNode(value) {
      const node = {
        value,
        next: undefined
      }
      if (!head) {
        head = node
        tail = node
      } else {
        tail.next = node
        tail = node
      }
      length += 1
    }
    function dequeueNode() {
      if (head) {
        const value = head.value
        head = head.next
        length -= 1
        return value
      }
      tail = undefined
      return undefined
    }
  },
  createSingleArrayQueue() {
    let queue = []
    return {
      enqueue(element) {
        queue.push(element)
      },
      dequeue() {
        return queue.shift()
      },
      size() {
        return queue.length
      }
    }
  },
  createDoubleArrayQueue() {
    let input = []
    let output = []
    return {
      enqueue(element) {
        input.push(element)
      },
      dequeue() {
        if (output.length === 0) {
          pivot()
        }
        return output.pop()
      },
      size() {
        return (input.length + output.length)
      }
    }
    function pivot() {
      output = input.reverse()
      input = []
    }
  }
}
