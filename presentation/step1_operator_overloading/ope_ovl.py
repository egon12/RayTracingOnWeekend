# Example Operator Overloading

class A:
    def __init__(self, words, number):
        self.words = words
        self.number = number

    def __add__(self, a):
        words = self.words.copy()
        words.extend(a.words)

        number = self.number + a.number
        return A(words, number)

    def __sub__(self, a):
        words = self.words.copy()
        for w in a.words:
            count = words.count(w)
            for i in range(count):
                words.remove(w)

        number = self.number - a.number
        return A(words, number)

    def __repr__(self): 
        r = "["
        for w in self.words:
            r += w + " "

        r += "] "

        r += str(self.number)
        return r

a1 = A(["satu"], 1)
a2 = A(["dua"], 2)

a3 = a1 + a2

print(a3)
print (a3 - a1)
