// Generated by CoffeeScript 1.7.1
(function() {
  var bt, cHTMLK, cKeyT, cRowD, cRowS, capl, chkerr, chkuni, clearAllChilds, crpt, e, eform, exp, gKey, getBackground, hde, iKVal, mField, rkey, rotk, rotm, rotp, upKForm;

  (function() {
    var _base;
    return (_base = Array.prototype).shuffle != null ? _base.shuffle : _base.shuffle = function() {
      var i, j, _i, _ref, _ref1;
      for (i = _i = _ref = this.length - 1; _ref <= 1 ? _i <= 1 : _i >= 1; i = _ref <= 1 ? ++_i : --_i) {
        j = Math.floor(Math.random() * (i + 1));
        _ref1 = [this[j], this[i]], this[i] = _ref1[0], this[j] = _ref1[1];
      }
      return this;
    };
  })();

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
      return "";
    } else {
      return "disabled";
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
      _results.push("<td class=\"" + (getBackground(k)) + "\">\n            <input type=\"text\" class=\"form-control\" id=\"" + (this.getKey(k + i * this.keycolumn)) + "\" " + (this.hide(k + i * this.keycolumn)) + "/>\n        </td>");
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
    var c, e, e2, input, out, t, v, _i, _len;
    e = document.getElementById("inputTxt");
    input = e.value;
    out = "";
    for (_i = 0, _len = input.length; _i < _len; _i++) {
      c = input[_i];
      if (c in this.keyTable) {
        v = this.keyTable[c];
        if (v === "" || v === " ") {
          v = ".";
        }
        out += v;
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

  mField = function() {
    var c, cN, e, _i, _len, _ref;
    _ref = this.errorArray;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      c = _ref[_i];
      if (c !== void 0) {
        e = document.getElementById(c);
        cN = e.parentElement.className;
        if (cN !== "has-error") {
          this.keyClass[c] = cN;
          e.parentElement.className = "has-error";
        }
      }
    }
    return false;
  };

  chkerr = function() {
    var c, correct, e, hist, k, keys, lc, s, v, _i, _j, _k, _len, _len1, _len2, _ref, _results;
    keys = Object.keys(this.keyTable);
    hist = {};
    for (_i = 0, _len = keys.length; _i < _len; _i++) {
      k = keys[_i];
      v = this.keyTable[k];
      if (v !== "") {
        if (hist[v] === void 0) {
          hist[v] = 1;
        } else {
          hist[v] += 1;
        }
      }
    }
    e = document.getElementById("freechar");
    s = "";
    for (_j = 0, _len1 = keys.length; _j < _len1; _j++) {
      c = keys[_j];
      lc = c.toLocaleLowerCase();
      if (hist[lc] === void 0) {
        s += "<code>" + lc + "</code>";
      }
    }
    e.innerHTML = s;
    correct = [];
    _ref = this.errorArray;
    _results = [];
    for (_k = 0, _len2 = _ref.length; _k < _len2; _k++) {
      c = _ref[_k];
      if ((hist[this.keyTable[c]] === void 0 || hist[this.keyTable[c]] < 2) && this.keyClass[c] !== "") {
        e = document.getElementById(c);
        if (e.parentElement !== null) {
          e.parentElement.className = this.keyClass[c];
          this.keyClass[c] = "";
          this.errorArray.splice(this.errorArray.indexOf(c), 1);
        }
        _results.push(this.checkError());
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  chkuni = function(k, v) {
    var key, keys, values;
    if (v !== "") {
      keys = Object.keys(this.keyTable);
      values = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = keys.length; _i < _len; _i++) {
          key = keys[_i];
          _results.push(this.keyTable[key]);
        }
        return _results;
      }).call(this);
      this.keyTable[k] = v;
      this.updateKeyForm();
      if (values.indexOf(v) > -1 && v !== " " && v !== "") {
        this.errorArray.push(keys[values.indexOf(v)]);
        this.errorArray.push(k);
        this.markField();
      }
      this.checkError();
    }
    return false;
  };

  rkey = function() {
    var keys, v;
    keys = Object.keys(this.keyTable);
    v = keys.shuffle();
    alert(v);
    return false;
  };

  exp = {
    name: "Monoalphabetisch",
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
    checkunique: chkuni,
    checkError: chkerr,
    markField: mField,
    hide: hde,
    getKey: gKey,
    capitalize: capl,
    crypt: crpt,
    randomkey: rkey
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

  exp.errorArray = [];

  exp.keyClass = {};

  exp.createKeyTable();

  exp.updateKeyForm();

  exp.capitalize();

  exp.crypt();

  exp.randomkey();

  bt = document.getElementById("btn_crypt");

  bt.onclick = function(e) {
    exp.capitalize();
    exp.crypt();
    return false;
  };

  eform = document.getElementById("inputTxt");

  eform.onkeypress = function(e) {
    if (!e) {
      e = window.event;
    }
    if (e.keyCode === 13) {
      exp.capitalize();
      exp.crypt();
      return false;
    }
  };

  e = document.getElementById("keytable");

  e.onkeyup = function(e) {
    var src;
    src = e.srcElement || e.target;
    src.value = src.value.toLocaleLowerCase();
    if (src.value.length > 1) {
      src.value = src.value[0];
    }
    return exp.checkunique(src.id, src.value);
  };

}).call(this);
