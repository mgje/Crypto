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
		@keyTable[key]=key


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
		@rotm

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
            <input type="text" class="form-control" id="#{@getKey(k+i*@keycolumn)}" />
        </td>
		"""


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
	getKey : gKey
	
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
	"Ä" : ""
	"Ö"	: ""
	"Ü" : ""

exp.initKeyValues()
exp.createKeyTable()
exp.rotkey(13)

exp.updateKeyForm()





