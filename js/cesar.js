// Generated by CoffeeScript 1.7.1
(function() {
  var bt, cHTMLK, cKeyT, cRowD, cRowS, capl, clearAllChilds, crpt, decrpt, eform, exp, gKey, getBackground, hde, iKVal, mkIKTable, rotk, rotm, rotp, upKForm;

  clearAllChilds = function(id) {
    var e;
    e = document.getElementById(id);
    while (e.hasChildNodes()) {
      e.removeChild(e.lastChild);
    }
    return e;
  };

  upKForm = function() {
    var e, key, keys, _i, _len;
    keys = Object.keys(this.keyTable);
    for (_i = 0, _len = keys.length; _i < _len; _i++) {
      key = keys[_i];
      e = document.getElementById(key);
      e.setAttribute("value", this.keyTable[key]);
    }
    return false;
  };

  iKVal = function() {
    var key, keys, _i, _len, _results;
    keys = Object.keys(this.keyTable);
    _results = [];
    for (_i = 0, _len = keys.length; _i < _len; _i++) {
      key = keys[_i];
      _results.push(this.keyTable[key] = key.toLocaleLowerCase());
    }
    return _results;
  };

  rotp = function() {
    var key, keys, lastkey, tmp2, tmpValue, _i, _len;
    keys = Object.keys(this.keyTable);
    lastkey = keys[keys.length - 1];
    tmpValue = this.keyTable[lastkey];
    for (_i = 0, _len = keys.length; _i < _len; _i++) {
      key = keys[_i];
      tmp2 = tmpValue;
      tmpValue = this.keyTable[key];
      this.keyTable[key] = tmp2;
    }
    return false;
  };

  rotm = function() {
    var key, keys, lastkey, tmp2, tmpValue, _i, _len;
    keys = Object.keys(this.keyTable);
    keys.reverse();
    lastkey = keys[keys.length - 1];
    tmpValue = this.keyTable[lastkey];
    for (_i = 0, _len = keys.length; _i < _len; _i++) {
      key = keys[_i];
      tmp2 = tmpValue;
      tmpValue = this.keyTable[key];
      this.keyTable[key] = tmp2;
    }
    return false;
  };

  rotk = function(N) {
    var k, _i, _results;
    _results = [];
    for (k = _i = 0; 0 <= N ? _i < N : _i > N; k = 0 <= N ? ++_i : --_i) {
      _results.push(this.rotminus1());
    }
    return _results;
  };

  cKeyT = function() {
    var el;
    el = document.getElementById("keytable");
    return el.innerHTML = this.createHtmlKeys().join("");
  };

  cHTMLK = function() {
    var Nkeys, i, keyrows, keys, _i, _results;
    keys = Object.keys(this.keyTable);
    Nkeys = keys.length;
    keyrows = Math.floor(Nkeys / this.keycolumn) + 1;
    if (Nkeys % this.keycolumn === 0) {
      keyrows -= 1;
    }
    _results = [];
    for (i = _i = 0; 0 <= keyrows ? _i < keyrows : _i > keyrows; i = 0 <= keyrows ? ++_i : --_i) {
      _results.push("<table class=\"table\">\n            <tr>\n               " + (this.createRowSrc(i).join("")) + "\n            </tr>\n            <tr>\n               " + (this.createRowDest(i).join("")) + "\n            </tr>\n        </table>");
    }
    return _results;
  };

  getBackground = function(i) {
    if (i % 2 === 0) {
      return "success";
    } else {
      return "warning";
    }
  };

  gKey = function(i) {
    var keys, _ref;
    keys = Object.keys(this.keyTable);
    return (_ref = keys[i]) != null ? _ref : "";
  };

  hde = function(i) {
    var keys;
    keys = Object.keys(this.keyTable);
    if (i < keys.length) {
      return " ";
    } else {
      return "hide";
    }
  };

  cRowS = function(i) {
    var k, keys, _i, _ref, _results;
    keys = Object.keys(this.keyTable);
    _results = [];
    for (k = _i = 0, _ref = this.keycolumn; 0 <= _ref ? _i < _ref : _i > _ref; k = 0 <= _ref ? ++_i : --_i) {
      _results.push("<td class=\"" + (getBackground(k)) + " text-center\">" + (this.getKey(k + i * this.keycolumn)) + "</td>");
    }
    return _results;
  };

  cRowD = function(i) {
    var k, keys, _i, _ref, _results;
    keys = Object.keys(this.keyTable);
    _results = [];
    for (k = _i = 0, _ref = this.keycolumn; 0 <= _ref ? _i < _ref : _i > _ref; k = 0 <= _ref ? ++_i : --_i) {
      _results.push("<td class=\"" + (getBackground(k)) + "\">\n            <input type=\"text\" class=\"form-control\" id=\"" + (this.getKey(k + i * this.keycolumn)) + "\" disabled />\n        </td>");
    }
    return _results;
  };

  capl = function() {
    var e;
    e = document.getElementById("inputTxt");
    e.value = e.value.toLocaleUpperCase();
    return false;
  };

  crpt = function() {
    var c, e, e2, input, out, t, _i, _len;
    e = document.getElementById("inputTxt");
    input = e.value;
    out = "";
    for (_i = 0, _len = input.length; _i < _len; _i++) {
      c = input[_i];
      if (c in this.keyTable) {
        out += this.keyTable[c];
      } else {
        out += c;
      }
    }
    out = out.toLocaleLowerCase();
    e2 = clearAllChilds("outputTxt");
    t = document.createTextNode(out);
    e2.appendChild(t);
    return false;
  };

  decrpt = function() {
    var c, e, e2, input, out, t, _i, _len;
    e = document.getElementById("inputTxt");
    input = e.value;
    out = "";
    for (_i = 0, _len = input.length; _i < _len; _i++) {
      c = input[_i];
      if (c in this.invkeyTable) {
        out += this.invkeyTable[c];
      } else {
        out += c;
      }
    }
    out = out.toLocaleLowerCase();
    e2 = clearAllChilds("outputTxt");
    t = document.createTextNode(out);
    e2.appendChild(t);
    return false;
  };

  mkIKTable = function() {
    var ikT, k, keys, v, _i, _len;
    keys = Object.keys(this.keyTable);
    ikT = {};
    for (_i = 0, _len = keys.length; _i < _len; _i++) {
      k = keys[_i];
      v = this.keyTable[k].toLocaleUpperCase();
      ikT[v] = k.toLocaleLowerCase();
    }
    this.invkeyTable = ikT;
    return false;
  };

  exp = {
    name: "Cesar",
    keycolumn: 10,
    initKeyValues: iKVal,
    updateKeyForm: upKForm,
    rotplus1: rotp,
    rotminus1: rotm,
    rotkey: rotk,
    createKeyTable: cKeyT,
    createHtmlKeys: cHTMLK,
    createRowSrc: cRowS,
    createRowDest: cRowD,
    hide: hde,
    getKey: gKey,
    capitalize: capl,
    crypt: crpt,
    decrypt: decrpt,
    makeInvKeyTable: mkIKTable
  };

  exp.keyTable = {
    "A": "",
    "B": "",
    "C": "",
    "D": "",
    "E": "",
    "F": "",
    "G": "",
    "H": "",
    "I": "",
    "J": "",
    "K": "",
    "L": "",
    "M": "",
    "N": "",
    "O": "",
    "P": "",
    "Q": "",
    "R": "",
    "S": "",
    "T": "",
    "U": "",
    "V": "",
    "W": "",
    "X": "",
    "Y": "",
    "Z": ""
  };

  exp.initKeyValues();

  exp.createKeyTable();

  exp.rotkey(3);

  exp.updateKeyForm();

  exp.capitalize();

  exp.crypt();

  bt = document.getElementById("btn_crypt");

  bt.onclick = function(e) {
    exp.capitalize();
    exp.crypt();
    return false;
  };

  bt = document.getElementById("btn_decrypt");

  bt.onclick = function(e) {
    exp.capitalize();
    exp.makeInvKeyTable();
    exp.decrypt();
    return false;
  };

  eform = document.getElementById("inputTxt");

  eform.onkeydown = function(e) {
    var savepos;
    if (!e) {
      e = window.event;
    }
    savepos = e.currentTarget.selectionEnd;
    exp.capitalize();
    exp.crypt();
    e.currentTarget.selectionEnd = savepos;
    return true;
  };

}).call(this);
