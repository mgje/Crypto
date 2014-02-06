var assert = buster.assert;

var A;

var preisSorter = function(a, b) {
            return a[1] > b[1] ? 1 : (a[1] < b[1] ? -1 : 0);
        }

buster.testCase("Sort 8 Elements", {
    setUp: function () {

        
    
        A = [];
        A.push([1, 4]);
        A.push([2, 4]);
        A.push([3, 2]);
        A.push([4, 2]);
        A.push([5, 1]);
        A.push([6, 1]);
        A.push([7, 2]);
        A.push([8, 1]);
     
    },
    "Element 0": function () {
        assert.equals(A[0], [1, 4]);
    },
    "Element 1": function () {
        assert.equals(A[1], [2, 4]);
    },
    "Element 2": function () {
        assert.equals(A[2], [3, 2]);
    },
    "Element 3": function () {
        assert.equals(A[3], [4, 2]);
    },
    "Element 4": function () {
        assert.equals(A[4], [5, 1]);
    },
    "Element 5": function () {
        assert.equals(A[5], [6, 1]);
    },
    "Sort": function () {
        var B = [[5, 1],[6, 1],[8, 1],[3,2],[4, 2],[7, 2],[1, 4],[2, 4]];
        A.sort(preisSorter);
        assert.equals(A, B);
    }

});
