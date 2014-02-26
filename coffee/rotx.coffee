# Experiment 1 
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
		@keyTable[key]=key.toLocaleLowerCase()


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
               #{@createRowDest(i).join ""}
            </tr>
        </table>
        """
getBackground = (i) ->
	if (i%2==0)
		"success"
	else
		"warning"

gKey = (i) ->
	keys = Object.keys @keyTable
	keys[i] ? ""

hde = (i) ->
	keys = Object.keys @keyTable
	if i < keys.length
		" "
	else
		"hide"


cRowS = (i) ->
	keys = Object.keys @keyTable
	for k in [0...@keycolumn]
		"""
		<td class="#{getBackground(k)} text-center">#{@getKey(k+i*@keycolumn)}</td>
		"""

cRowD = (i) ->
	keys = Object.keys @keyTable
	for k in [0...@keycolumn]
		"""
		<td class="#{getBackground(k)}">
            <input type="text" class="form-control" id="#{@getKey(k+i*@keycolumn)}" disabled />
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
			out += @keyTable[c]
		else
			out += c
	out = out.toLocaleLowerCase()
	e2 = clearAllChilds "outputTxt"
	t = document.createTextNode out
	e2.appendChild t
	false


exp = 
	name : "Cesar"
	keycolumn : 10
	initKeyValues : iKVal
	updateKeyForm : upKForm
	rotplus1 : rotp
	rotminus1 : rotm
	rotkey : rotk
	createKeyTable : cKeyT
	createHtmlKeys : cHTMLK
	createRowSrc : cRowS
	createRowDest : cRowD
	hide : hde
	getKey : gKey
	capitalize : capl
	crypt : crpt
	
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

exp.initKeyValues()
exp.createKeyTable()
exp.updateKeyForm()
exp.capitalize()
exp.crypt()

# Event Listener
bt = document.getElementById "btn_crypt"
bt.onclick = (e) ->
	exp.capitalize()
	exp.crypt()
	false 	

bt = document.getElementById "btn_left"
bt.onclick = (e) ->
	exp.rotminus1()
	exp.updateKeyForm()
	false 

bt = document.getElementById "btn_right"
bt.onclick = (e) ->
	exp.rotplus1()
	exp.updateKeyForm()
	false 


# Enter
eform = document.getElementById "inputTxt"
eform.onkeypress = (e) ->
	if !e
		e = window.event
	if e.keyCode ==13
		exp.capitalize()
		exp.crypt()
		false



