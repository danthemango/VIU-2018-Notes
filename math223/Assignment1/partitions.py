def partition(collection):
    if len(collection) == 1:
        yield [ collection ]
        return

    first = collection[0]
    for smaller in partition(collection[1:]):
        # insert `first` in each of the subpartition's subsets
        for n, subset in enumerate(smaller):
            yield smaller[:n] + [[ first ] + subset]  + smaller[n+1:]
        # put `first` in its own subset 
        yield [ [ first ] ] + smaller


something = [2,3,5,7,11,13,17]

total = 0
for n, p in enumerate(partition(something), 1):
    if len(p) == 3:
        print(p)
        total += 1

print(total)
