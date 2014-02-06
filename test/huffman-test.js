var assert = buster.assert;

var mystr;
var code;

buster.testCase("Huffman Test", {
    setUp: function () {
        mystr = "Kenne mer nit, bruche mer nit, fott domet!";
        code = "01010101110111011011111100101100111111010001011100011101001100100100010000010110111111001011001111110100010111000111001100000011011111001110000110010101101011";
        
    },
    "Huffman encode": function () {
        var huf = Huffman.treeFromText(mystr);
        var enc = huf.encode(mystr);
        var encbin = huf.stringToBitString(enc);
        assert.equals(encbin,code);
    }

});
