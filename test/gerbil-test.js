// var buster = require("buster");

buster.spec.expose();

describe("Gerbil", function(){
	it("knows math too", function(){
		expect(2+3).toEqual(5);
	});
});
