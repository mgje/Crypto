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
		<td class="#{getBackground(k)} text-center">#{@getKey(k+i*@keycolumn)}</td>
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


crpt = () ->
	e = document.getElementById "inputTxt"
	input = e.value
	out = ""
	for c in input
		if c of @keyTable
			v = @keyTable[c]
			if v == "" || v == " "
				v = "."
			out += v
		else
			out += c

	e2 = clearAllChilds "outputTxt"
	t = document.createTextNode out
	e2.appendChild t
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
	@initKeyProz()
	e = document.getElementById "inputTxt"
	input = e.value
	count = 0
	for c in input
		if c of @keyTable
			count += 1
			@keyProz[c] +=1

	keys = Object.keys @keyTable
	for c in keys
		@keyProz[c] = @keyProz[c]/count*100

	@writehisto()
	false

whisto = () ->
	keys = Object.keys @keyTable
	for c in keys
		s = "P-"+c
		e = clearAllChilds s
		num = parseFloat @keyProz[c]
		if isNaN num
			tx = ""
		else
			tx = ""+num.toFixed(1)+"%"

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
	crypt : crpt
	calchisto : chist
	writehisto : whisto
	sortcharlist : schr

exp.keyTable = 
	"A" : ""
	"B"	: ""
	"C" : ""
	"D"	: ""
	"E" : ""
	"F"	: ""
	"G" : ""
	"H"	: ""
	"I" : ""
	"J"	: ""
	"K" : ""
	"L"	: ""	
	"M" : ""
	"N"	: ""
	"O" : ""
	"P"	: ""
	"Q" : ""
	"R"	: ""
	"S" : ""
	"T"	: ""
	"U" : ""
	"V"	: ""	
	"W" : ""
	"X"	: ""
	"Y" : ""
	"Z"	: ""

exp.errorArray = []
exp.keyClass = {}
exp.keyProz = {}
exp.initKeyProz()
# exp.calchisto()
#exp.initKeyValues()
exp.createKeyTable()
#exp.rotkey 3
exp.updateKeyForm()
exp.capitalize()
exp.crypt()
exp.calchisto()

# Event Listener
bt = document.getElementById "btn_crypt"
bt.onclick = (e) ->
	exp.capitalize()
	exp.crypt()
	exp.calchisto()
	false 	

# Enter
eform = document.getElementById "inputTxt"
eform.onkeypress = (e) ->
	if !e
		e = window.event
	if e.keyCode ==13
		exp.capitalize()
		exp.crypt()
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






