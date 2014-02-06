//var config = module.exports;
var config = exports;

config["My tests"]={
	env: "browser",
	rootPath: "../",
	sources: [
		"public/js/huffman-0.9.1.js",
		"tools/lib/*.js"
	],
	tests: [
		"test/*-test.js"
	]
};