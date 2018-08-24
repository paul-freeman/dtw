import numpy as np
cimport numpy as np
cimport cython
from libc.math cimport fabs, INFINITY


def dtw(np.ndarray[np.float64_t, ndim=1, mode="c"] list1, np.ndarray[np.float64_t, ndim=1, mode="c"] list2):
    cdef double[:, ::1] costs = np.empty((len(list1)+1, len(list2)+1), dtype='float64')
    cdef char[:, ::1] path = np.empty((len(list1)+1, len(list2)+1), dtype='uint8')
    cdef int i, j
    _calc_costs(costs, path, list1, list2)
    i = costs.shape[0] - 1
    j = costs.shape[1] - 1
    index1 = [i]
    index2 = [j]
    while i > 1 or j > 1:
        if path[i, j] == 1:
            i, j = i-1, j
        elif path[i, j] == 2:
            i, j = i, j-1
        else: # path[i, j] == 3:
            i, j = i-1, j-1
        index1.append(i)
        index2.append(j)
    index1.reverse()
    index2.reverse()
    return (float(costs[-1, -1]),
            np.asarray(index1, dtype=int),
            np.asarray(index2, dtype=int),
            costs[1:, 1:])


@cython.boundscheck(False)
@cython.wraparound(False)
cdef void _calc_costs(double[:, ::1] costs, char[:, ::1] path, double[::1] list1, double[::1] list2):
    cdef int i, j
    costs[0, 0] = -(fabs(list1[0] - list2[0]))
    costs[0, 1:] = INFINITY
    costs[1:, 0] = INFINITY
    path[0, 0] = 0
    path[0, 1:] = 0
    path[1:, 0] = 0
    for i in range(1, costs.shape[0]):
        for j in range(1, costs.shape[1]):
            distance = fabs(list1[i-1] - list2[j-1])
            if costs[i-1, j] < costs[i, j-1] and  costs[i-1, j] - costs[i-1, j-1] < distance:
                costs[i, j], path[i, j] = costs[i-1, j] + distance, 1
                continue
            if costs[i, j-1] - costs[i-1, j-1] < distance:
                costs[i, j], path[i, j] = costs[i, j-1] + distance, 2
                continue
            costs[i, j], path[i, j] = costs[i-1, j-1] + distance * 2, 3
    return
