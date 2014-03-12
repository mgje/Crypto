# Entschlüsseln / Decrypt 
clearAllChilds = (id)->
	e = document.getElementById id
	while e.hasChildNodes()
		e.removeChild e.lastChild
	e

upKForm = () -> 
	keys = Object.keys @keyTable
	for key in keys
		e = document.getElementById key
		e.setAttribute "value",@keyTable[key]
	false

iKVal = () ->
	keys = Object.keys @keyTable
	for key in keys
		@keyTable[key]=key

iKProz = () ->
	keys = Object.keys @keyTable
	for key in keys
		@keyProz[key]=0.0


iKAbs = () ->
	keys = Object.keys @keyTable
	for key in keys
		@keyAbs[key]=0.0


rotp = () ->
	keys = Object.keys @keyTable
	lastkey = keys[keys.length-1]
	tmpValue = @keyTable[lastkey]
	for key in keys
		tmp2 = tmpValue
		tmpValue = @keyTable[key]
		@keyTable[key] = tmp2
	false

rotm = () ->
	keys = Object.keys @keyTable
	keys.reverse()
	lastkey = keys[keys.length-1]
	tmpValue = @keyTable[lastkey]
	for key in keys
		tmp2 = tmpValue
		tmpValue = @keyTable[key]
		@keyTable[key] = tmp2
	false	

rotk = (N) ->
	for k in [0...N]
		@rotminus1()

# create HTML Key Tables
cKeyT = () ->
   el = document.getElementById "keytable"
   el.innerHTML = @createHtmlKeys().join ""



# create HTML Key Tables
cHTMLK = () ->
	keys = Object.keys @keyTable
	Nkeys = keys.length
	keyrows = Math.floor(Nkeys/@keycolumn)+1
	if (Nkeys%@keycolumn == 0)
		keyrows -= 1
	
	for i in [0...keyrows]
		"""
		<table class="table">
            <tr>
               #{@createRowSrc(i).join ""}
            </tr>
            <tr>
               #{@createRowProz(i).join ""}
            </tr>
            <tr>
               #{@createRowDest(i).join ""}
            </tr>
        </table>
        """
getBackground = (i) ->
	if (i%2==0)
		"success"
	else
		"warning"

getProzZ = (n,l) ->
	if n<l
		"%"
	else
		""

gKey = (i) ->
	keys = Object.keys @keyTable
	keys[i] ? ""

gProz = (i) ->
	keys = Object.keys @keyTable
	num = parseFloat @keyProz[keys[i]]
	if isNaN num 
		""
	else
		num.toFixed 1 
	

hde = (i) ->
	keys = Object.keys @keyTable
	if i < keys.length
		""
	else
		"disabled"


cRowS = (i) ->
	keys = Object.keys @keyTable
	for k in [0...@keycolumn]
		"""
		<td class="#{getBackground(k)} text-center">#{@getKey(k+i*@keycolumn).toLocaleLowerCase()}</td>
		"""

cRowP = (i) ->
	keys = Object.keys @keyTable
	for k in [0...@keycolumn]
		"""
		<td class="#{getBackground(k)} text-center tinyfont"><small
			id=P-#{@getKey(k+i*@keycolumn)} >#{@getProz(k+i*@keycolumn)} #{getProzZ(k+i*@keycolumn,keys.length)}</small></td>
		"""

cRowD = (i) ->
	keys = Object.keys @keyTable
	for k in [0...@keycolumn]
		"""
		<td class="#{getBackground(k)}">
            <input type="text" class="form-control" id="#{@getKey(k+i*@keycolumn)}" #{@hide(k+i*@keycolumn)}/>
        </td>
		"""
# {@hide(k+i*@keycolumn)}

capl = () ->
	e = document.getElementById "inputTxt"
	e.value = e.value.toLocaleUpperCase()
	false

lowCas = () ->
	e = document.getElementById "inputTxt"
	e.value = e.value.toLocaleLowerCase()
	false

decrpt = () ->
	e = document.getElementById "inputTxt"
	input = e.value
	out = ""
	@NumEncCharacters = 0
	for c in input
		if c of @keyTable
			v = @keyTable[c]
			if v == "" || v == " "
				v = "."
			out += v
			@NumEncCharacters += 1
		else
			out += c
	out = out.toLocaleUpperCase()
	e2 = clearAllChilds "outputTxt"
	t = document.createTextNode out
	e2.appendChild t
	e3 = clearAllChilds "tot_enc_char"
	t3 = document.createTextNode @NumEncCharacters
	e3.appendChild t3
	false

mField = () ->
	for c in @errorArray
		if c != undefined
			e = document.getElementById c
			cN = e.parentElement.className
			if cN != "has-error"
				@keyClass[c]=cN
				e.parentElement.className = "has-error"
	false

chkerr = () ->
	keys = Object.keys @keyTable
	hist = {}
	for k in keys
		v = @keyTable[k]
		if v != ""
			if hist[v] == undefined
				hist[v] = 1
			else
				hist[v] += 1
    
    correct = []
	for c in @errorArray
		if (hist[@keyTable[c]]  == undefined || hist[@keyTable[c]] < 2) && @keyClass[c] != ""
			e = document.getElementById c
			e.parentElement.className = @keyClass[c]
			@keyClass[c] = ""
			@errorArray.splice @errorArray.indexOf(c),1
			# @updateKeyForm()
			@checkError()
	
chkuni = (k,v) ->
	if v != ""
		keys = Object.keys @keyTable
		values = (@keyTable[key] for key in keys)
		@keyTable[k]=v
		@updateKeyForm()
		
		if values.indexOf(v) > -1 && v != " " && v != ""
			@errorArray.push keys[values.indexOf v]
			@errorArray.push k
			@markField()
		
		@checkError()
	false

chist = () ->
	@initKeyAbs()
	e = document.getElementById "inputTxt"
	input = e.value
	count = 0
	for c in input
		if c of @keyTable
			count += 1
			@keyAbs[c] +=1

	keys = Object.keys @keyTable
	

	for c in keys
		@keyProz[c] = @keyAbs[c]/count*100

	@writehisto()
	false

whisto = () ->
	keys = Object.keys @keyTable
	for c in keys
		s = "P-"+c
		e = clearAllChilds s
		if @stateSwitch == "relative"
			num = parseFloat @keyProz[c]
			if isNaN num
				tx = ""
			else
				tx = ""+num.toFixed(1)+"%"
		else
			num = @keyAbs[c]
			if isNaN num
				tx = ""
			else
				tx = ""+num

		t = document.createTextNode tx
		e.appendChild t
	
	@sortcharlist()
	false

schr = () ->
	el= document.getElementById "crypC0"
	if el != null
		keys = Object.keys @keyTable
		charproz = []
		for c in keys
			tmp = [@keyProz[c],c]
			charproz.push tmp

		charproz.sort (a,b) -> 
						b[0]-a[0]

		for i in [0...10]
			tmp = charproz[i]
			s = "crypC"+i
			e = clearAllChilds s
			t = document.createTextNode tmp[1]
			e.appendChild t
			s = "crypV"+i
			e = clearAllChilds s
			num = parseFloat tmp[0]
			if isNaN num
				tx = ""
			else
				tx = ""+num.toFixed(1)+"%"
			t = document.createTextNode tx
			e.appendChild t
	
	false

exp = 
	name : "DeCrypt"
	keycolumn : 10
	initKeyValues : iKVal
	initKeyProz : iKProz
	initKeyAbs : iKAbs
	updateKeyForm : upKForm
	rotplus1 : rotp
	rotminus1 : rotm
	rotkey : rotk
	createKeyTable : cKeyT
	createHtmlKeys : cHTMLK
	createRowSrc : cRowS
	createRowDest : cRowD
	createRowProz : cRowP
	checkunique : chkuni
	checkError : chkerr
	markField : mField
	hide : hde
	getKey : gKey
	getProz : gProz
	capitalize : capl
	lowerCase : lowCas
	decrypt : decrpt
	calchisto : chist
	writehisto : whisto
	sortcharlist : schr

exp.keyTable = 
	"a" : ""
	"b"	: ""
	"c" : ""
	"d"	: ""
	"e" : ""
	"f"	: ""
	"g" : ""
	"h"	: ""
	"i" : ""
	"j"	: ""
	"k" : ""
	"l"	: ""	
	"m" : ""
	"n"	: ""
	"o" : ""
	"p"	: ""
	"q" : ""
	"r"	: ""
	"s" : ""
	"t"	: ""
	"u" : ""
	"v"	: ""	
	"w" : ""
	"x"	: ""
	"y" : ""
	"z"	: ""

exp.NumEncCharacters = 1
exp.stateSwitch = "relative"
exp.errorArray = []
exp.keyClass = {}
exp.keyProz = {}
exp.keyAbs = {}
exp.initKeyProz()
exp.createKeyTable()
exp.updateKeyForm()
exp.lowerCase()
exp.decrypt()
exp.calchisto()

# Event Listener
bt = document.getElementById "btn_crypt"
bt.onclick = (e) ->
	exp.lowerCase()
	exp.decrypt()
	exp.calchisto()
	false 	

bt = document.getElementById "stat_rel"
bt.onclick = (e) ->
	e2 = document.getElementById "stat_rel"
	indx = e2.className.indexOf "active"
	if indx > -1
		# alert "do nothing"
	else
		# alert "do it"
		exp.stateSwitch = "relative"
		exp.writehisto()
		
	false 	

bt = document.getElementById "stat_abs"
bt.onclick = (e) ->
	e2 = document.getElementById "stat_abs"
	indx = e2.className.indexOf "active"
	if indx > -1
		# alert "do nothing"
	else
		# alert "do it"
		exp.stateSwitch = "absolute"
		exp.writehisto()
		
	false 	

# Enter
eform = document.getElementById "inputTxt"
eform.onkeypress = (e) ->
	if !e
		e = window.event
	if e.keyCode ==13
		exp.lowerCase()
		exp.decrypt()
		exp.calchisto()
		false

# Forms
e = document.getElementById "keytable"
e.onkeyup = (e) ->
	src = e.srcElement || e.target
	src.value = src.value.toLocaleUpperCase()
	if src.value.length > 1
		src.value = src.value[0]
	exp.checkunique(src.id,src.value)






