
# Knacknuss
# Help Functions
# Array Shuffle

do -> Array::shuffle ?= ->
  for i in [@length-1..1]
    j = Math.floor Math.random() * (i + 1)
    [@[i], @[j]] = [@[j], @[i]]
  @

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
				v = "<span class= 'disabled'>"+c+"</span>"
			else
				v = "<span class='active'>"+v+"</span>"
			out += v
			@NumEncCharacters += 1
		else
			out += "<span class='active'>" + c.toLocaleUpperCase() + "</span>"
	# out = out.toLocaleUpperCase()
	e2 = clearAllChilds "outputTxt"
	e2.innerHTML = out
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
			if e != null
				e.parentElement.className = @keyClass[c]
			@keyClass[c] = ""
			@errorArray.splice @errorArray.indexOf(c),1
			# @updateKeyForm()
			@checkError()
	
chkuni = (k,v) ->
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

rkey = () ->
	keys = Object.keys @keyTable
	v = Object.keys @keyTable
	v.shuffle()
	
	for i in [0...keys.length]
		c = v[i]
		@keyTable[keys[i]] = c.toLocaleLowerCase()

	@updateKeyForm()
	@decrypt()
	false

ckey = () ->
	keys = Object.keys @keyTable
	for i in [0...keys.length]
		@keyTable[keys[i]] = ""

	@updateKeyForm()
	@decrypt()
	false

nProb = () ->
	maxN = @geheimnisse.length
	ind = Math.floor Math.random()*maxN
	e = clearAllChilds "inputTxt"
	#t = document.createTextNode @geheimnisse[ind]
	#e.appendChild t
	e.value = @geheimnisse[ind]
	@randomkey()
	e2 = document.getElementById "outputTxt"
	e = clearAllChilds "inputTxt"
	#t = document.createTextNode e2.innerText
	#e.appendChild t
	if e2.innerText != undefined
		e.value = e2.innerText
	else
		e.value = e2.textContent
	@clearkey()
	@lowerCase()
	@decrypt()
	@calchisto()
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
	randomkey : rkey
	clearkey : ckey
	newProblem : nProb

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

# Geheimnisse
exp.geheimnisse =[]
exp.geheimnisse.push "ao cwx jqn vsae saca, wqb zajaj oea rkj vq dwqoa wqbxnaydaj gkjjpaj: aejaj zqnyd zwo caxeap zan oamqwjan, ajc qjz oydseanec, vseoydaj zai eqnw-caxenca qjz zan ndôja, sk gwqi aej swcaj bwdnaj gkjjpa, zkyd aej oadn dkdan xanc nwcpa wqb, ok zwoo oadn sajeca cwjv aejbwyd ranolannaj gkjjpaj. zan wjzana büdnpa zqnyd qjoana lnkrejv, reah haeydpan qjz xamqaian, saeh vseoydaj zaj caxeapaj zan dahrapean qjz zan whhkxnkcan, zea anop günvheyd qjpansknbaj sknzaj swnaj, zea ndôja bheaoop qjz oea wj aejecaj opahhaj zqnyd aeja bqnp üxanoydneppaj sanzaj gkjjpa. zea äqooanopa opwzp zan whhkxnkcan, zea zaj dahrapeanj wi jäydopaj heacp, eop cajb. rkj zeaoan opwzp wqo büdnp aeja xnüyga vq zaj dahrapeanj.  oea iaejpaj, oea sünzaj ajpsazan zea whhkxnkcan üxannazaj, zwoo oea oea zqnyd edn caxeap veadaj heaooaj, zw oea zai nöieoydaj rkhg jeydp canwza cqp caoejjp oydeajaj, kzan oea sünzaj oea zwvq vsejcaj. jwydzai whha owydaj vqi wqbxnqyd rknxanaepap swnaj, oapvpaj oea aejaj pwc baop, wj zai oeyd whha wi qban zan ndôja aejbejzaj okhhpaj. zeaoan pwc swn zan 5. rkn zaj gwhajzaj zao wlneho ei gkjoqhwpofwdna zao hqyeqo leok qjz wqhqo cwxejeqo."
exp.geheimnisse.push "reglhiq dyivwx wimr, heveyj hmi tjivhi eppiv eyw hiq wmglxjiph irxjivrx asvhir aevir, yq hir kiheroir er jpyglx, reglhiq hmi kijelv jüv eppi kpimgl kiqeglx asvhir aev, dy fiwimxmkir, ivöjjrixi gäwev, reglhiq iv hmi wimrir erkijiyivx lexxi, hmi wglpeglx. hmi wsphexir hyvglfslvxir, reglhiq zsr imriq lölivir svx wtiivi kiasvjir asvhir aevir, pimglx hmi wglpeglxvimli hiv jimrhi. reglhiq wmi hmi wglpeglxvimli eywimrerhivkixvmifir asvhir aev, qeglxir wmi qmx kidügoxir wglaivxir kikir hmiwi imrir erkvmjj. iw aev jüv hmi keppmiv imr kvswwiw lmrhivrmw jüv hmi wglpeglx, heww wmi, reglhiq wilv zmipi mlviv wglmphi hyvgl imrir ayvj hiv wtiivi hyvglfslvx yrh dyweqqirkilijxix asvhir aevir, he wmgl hew imwir zivfskir lexxi, wmi aihiv liveywdmilir rsgl qmx hiv filmrhivxir pmroir kirükirh yrkilmrhivx oäqtjir osrrxir, ws heww zmipi iw zsvdskir, reglhiq hiv evq perki lmr yrh liv kiwglüxxipx asvhir aev, hir wglmph aikdyaivjir yrh qmx yrkiwglüxdxiq oövtiv dy oäqtjir. wglpywwirhpmgl fikerrir wmi, aimp wmi hyvgl ayrhir ivwglötjx aevir, wsaslp dyvügodyaimglir, epw eygl, aimp imr fivk ixae 1000 hsttipwglvmxxi irxjivrx aev, wmgl hsvxlmr dyvügodydmilir. reglhiq hiv fivk imrkirsqqir asvhir aev yrh aälvirh yrwivi piyxi reglvügoxir yqdmrkipxir yrw hmi fsmiv yrh xypmrkiv, hmi - ixae 15.000 qerr - hir liiviwdyk hiv jimrhi efwglpswwir yrh hir lmrxivwxir dyq wglyxd kivimglxir hmi lmrxivwxir fiwglüxdir, reglhiq wmi eyw hiq qevwgl liveyw hmi yrwvmkir zsr hiv sjjirir wimxi liv erkikvmjjir lexxir.  erkiwmglxw hiwwir, fikerrir hmi lipzixmiv, hmi wmgl eyj hir fivk dyvügokidskir lexxir, amihivvyq wmgl  irxkikirdywxippir yrh amihiv mr hmi wglpeglx imrdywglvimxir. hmi vöqiv oäqtjxir, reglhiq hmi jiphdimglir kihvilx asvhir aevir, daimkiximpx mr daim vmglxyrkir: hmi ivwxi yrh daimxi wglpeglxvimli, yq hir fiwmikxir yrh dyvügokidskirir wxerh dy lepxir, hmi hvmxxi, yq hir kiosqqirir amhivwxerh dy pimwxir."
exp.geheimnisse.push "fyo pc dls kfc hpnvfsc styümpc, otp lfq opx vldepy etnvep. »stxxwtdnspc glepc!« olnsep pc, pd hlc slwm dtpmpy fsc, fyo otp kptrpc rtyrpy cfstr gzchäced, pd hlc dzrlc slwm gzcümpc, pd yäspcep dtns dnszy ocptgtpcepw. dzwwep opc hpnvpc ytnse rpwäfepe slmpy? xly dls gzx mpee lfd, oldd pc lfq gtpc fsc ctnsetr ptyrpdepwwe hlc; rphtdd sleep pc lfns rpwäfepe. ul, lmpc hlc pd xörwtns, otpdpd xömpwpcdnsüeepcyop wäfepy cfstr kf gpcdnswlqpy? yfy, cfstr sleep pc ul ytnse rpdnswlqpy, lmpc hlscdnsptywtns opdez qpdepc. hld lmpc dzwwep pc upeke efy? opc yänsdep kfr rtyr fx dtpmpy fsc; fx opy ptykfszwpy, säeep pc dtns fydtyytr mpptwpy xüddpy, fyo otp vzwwpvetzy hlc yzns ytnse ptyrpalnve, fyo pc dpwmde qüswep dtns ofcnslfd ytnse mpdzyopcd qctdns fyo mphprwtns. fyo dpwmde hpyy pc opy kfr ptyszwep, pty ozyypchpeepc opd nspqd hlc ytnse kf gpcxptopy, opyy opc rpdnsäqedotpypc sleep mptx qüyqfsckfr rphlcepe fyo otp xpwofyr gzy dptypc gpcdäfxytd wäyrde pcdeleepe. pd hlc ptyp vcplefc opd nspqd, zsyp cünvrcle fyo gpcdelyo. htp yfy, hpyy pc dtns vclyv xpwopep? old häcp lmpc äfddpcde aptywtns fyo gpcoänsetr, opyy rcprzc hlc häscpyo dptypd qüyquäsctrpy otpydepd yzns ytnse ptyxlw vclyv rphpdpy. rphtdd hücop opc nspq xte opx vclyvpyvlddpylcke vzxxpy, hücop opy pwepcy hprpy opd qlfwpy dzsypd gzchücqp xlnspy fyo lwwp ptyhäyop ofcns opy styhptd lfq opy vclyvpyvlddpylcke lmdnsyptopy, qüc opy pd ul ümpcslfae yfc rlyk rpdfyop, lmpc lcmpteddnspfp xpydnspy rtme. fyo säeep pc ümctrpyd ty otpdpx qlwwp dz rlyk fycpnse? rcprzc qüswep dtns eledänswtns, lmrpdpspy gzy ptypc ylns opx wlyrpy dnswlq htcvwtns ümpcqwüddtrpy dnswäqctrvpte, rlyk hzsw fyo sleep dzrlc ptypy mpdzyopcd vcäqetrpy sfyrpc."
exp.geheimnisse.push "re unggr va qvrfre notrneorvgrgra haq üorezüqrgra snzvyvr mrvg, fvpu hz tertbe zrue mh xüzzrea, nyf haorqvatg aögvt jne? qre unhfunyg jheqr vzzre zrue rvatrfpueäaxg; qnf qvrafgzäqpura jheqr aha qbpu ragynffra; rvar evrfvtr xabpuvtr orqvrareva zvg jrvffrz, qra xbcs hzsynggreaqrz unne xnz qrf zbetraf haq qrf noraqf, hz qvr fpujrefgr neorvg mh yrvfgra; nyyrf naqrer orfbetgr qvr zhggre arora vuere ivryra aäuneorvg. rf trfpunu fbtne, qnff irefpuvrqrar snzvyvrafpuzhpxfgüpxr, jrypur seüure qvr zhggre haq qvr fpujrfgre üoretyüpxyvpu orv hagreunyghatra haq srvreyvpuxrvgra trgentra unggra, irexnhsg jheqra, jvr tertbe nz noraq nhf qre nyytrzrvara orfcerpuhat qre remvrygra cervfr reshue. qvr teöffgr xyntr jne nore fgrgf, qnff zna qvrfr süe qvr trtrajäegvtra ireuäygavffr nyymhtebffr jbuahat avpug ireynffra xbaagr, qn rf avpug nhfmhqraxra jne, jvr zna tertbe üorefvrqrya fbyygr. nore tertbe fnu jbuy rva, qnff rf avpug ahe qvr eüpxfvpug nhs vua jne, jrypur rvar üorefvrqyhat ireuvaqregr, qraa vua uäggr zna qbpu va rvare cnffraqra xvfgr zvg rva cnne yhsgyöpurea yrvpug genafcbegvrera xöaara; jnf qvr snzvyvr unhcgfäpuyvpu ibz jbuahatfjrpufry nouvryg, jne ivryzrue qvr iöyyvtr ubssahatfybfvtxrvg haq qre trqnaxr qnena, qnff fvr zvg rvarz hatyüpx trfpuyntra jne, jvr avrznaq fbafg vz tnamra irejnaqgra- haq orxnaagraxervf. jnf qvr jryg iba nezra yrhgra ireynatg, resüyygra fvr ovf mhz ähffrefgra, qre ingre ubygr qra xyrvara onaxornzgra qnf seüufgüpx, qvr zhggre bcsregr fvpu süe qvr jäfpur serzqre yrhgr, qvr fpujrfgre yvrs anpu qrz orsruy qre xhaqra uvagre qrz chygr uva haq ure, nore jrvgre ervpugra qvr xeäsgr qre snzvyvr fpuba avpug. haq qvr jhaqr vz eüpxra svat tertbe jvr arh mh fpuzremra na, jraa zhggre haq fpujrfgre, anpuqrz fvr qra ingre mh orgg troenpug unggra, aha mheüpxxruegra, qvr neorvg yvrtra yvrffra, anur mhfnzzraeüpxgra, fpuba jnatr na jnatr fnffra; jraa wrgmg qvr zhggre, nhs tertbef mvzzre mrvtraq, fntgr: »znpu' qbeg qvr güe mh, tergr,« haq jraa aha tertbe jvrqre vz qhaxry jne, jäueraq arorana qvr senhra vuer geäara irezvfpugra bqre tne geäaraybf qra gvfpu nafgneegra."
exp.geheimnisse.push "zpl ilzjosvzzlu, klu olbapnlu ahn gbt hbzybolu buk zwhgplylunlolu gb clydluklu; zpl ohaalu kplzl hyilpazbualyiyljobun upjoa uby clykplua, zpl iyhbjoalu zpl zvnhy builkpuna. buk zv zlagalu zpl zpjo gbt apzjo buk zjoyplilu kylp luazjobskpnbunziyplml, olyy zhtzh hu zlpul kpylrapvu, myhb zhtzh hu poylu hbmayhnnlily, buk nylal hu poylu wypugpwhs. däoyluk klz zjoylpiluz rht kpl ilkplulypu olylpu, bt gb zhnlu, khzz zpl mvyanlol, kluu poyl tvynluhyilpa dhy illukla. kpl kylp zjoylpiluklu upjralu gblyza isvzz, voul hbmgbzjohblu, lyza hsz kpl ilkplulypu zpjo pttly uvjo upjoa luamlyulu dvssal, zho thu äynlyspjo hbm. »ubu?« myhnal olyy zhtzh. kpl ilkplulypu zahuk säjolsuk pu kly aüy, hsz ohil zpl kly mhtpspl lpu nyvzzlz nsüjr gb tlsklu, dlykl lz hily uby khuu abu, dluu zpl nyüukspjo hbznlmyhna dlykl. kpl mhza hbmyljoal rslpul zayhbzzmlkly hbm poylt oba, üily kpl zpjo olyy zhtzh zjovu däoyluk poyly nhuglu kpluzaglpa äynlyal, zjodhural slpjoa uhjo hsslu ypjoabunlu. »hszv dhz dvsslu zpl lpnluaspjo?« myhnal myhb zhtzh, cvy dlsjoly kpl ilkplulypu uvjo ht tlpzalu ylzwlra ohaal. »qh,« huadvyalal kpl ilkplulypu buk rvuual cvy mylbukspjolt shjolu upjoa nslpjo dlpaly ylklu, »hszv khyüily, dpl khz glbn cvu uliluhu dlnnlzjohmma dlyklu zvss, tüzzlu zpl zpjo rlpul zvynl thjolu. lz pza zjovu pu vykubun.« myhb zhtzh buk nylal ilbnalu zpjo gb poylu iyplmlu uplkly, hsz dvssalu zpl dlpalyzjoylpilu; olyy zhtzh, dlsjoly tlyral, khzz kpl ilkplulypu ubu hsslz hbzmüoyspjo gb ilzjoylpilu humhunlu dvssal, dloyal kplz tpa hbznlzayljraly ohuk luazjoplklu hi. kh zpl hily upjoa lygäoslu kbymal, lypuulyal zpl zpjo hu kpl nyvzzl lpsl, kpl zpl ohaal, yplm vmmluihy ilslpkpna: »hkqlz hsszlpaz,« kyloal zpjo dpsk bt buk clysplzz bualy müyjoalyspjolt aüylgbzjoshnlu kpl dvoubun."
exp.geheimnisse.push "ykdincpjij oit scpivkbntik ivkjökvdzivj dnb is oikklcp vk ykstit bütditscpnej bösi yko dyji, mltkipri yko ditvkdi, räcpjvdi yko kviotvdi yko kibik rnkcpik zqydik ivki itdöjhqvcpi zqivki snrrqykd mlk knttik, ovi ztijvks dnt kvcpj rvjditicpkij. is wnt wvi übitnqq ivk zqivkis nbbvqo oit dtlssik wiqj yko on dtlssi yko zqivki, scpqnyrivit yko knttik ykqösqvcp ykjitivknkoit mitwnkoj yko mitmijjitj wntik, jtnjik svcp sjtikdit plcpryj yko bltkvitjit qivcpjsvkk lej dikyd ykjit oirsiqbik oncp nye ovi hipik, sl onss yksit qibik eüt ovi jviei yko zlrvz ois rikscpqvcpik pvktivcpikoik tnyr blj. kyt qnd ivk iwvdit scpqivit mlk mitpivrqvcpjit loit ykbiwyssjit biotüczjpivj ontübit. ons nbpäkdvdsivk mlk oik knjyträcpjik yko ovi zürritqvcpzivj ivkis ntbivjsmlqqik onsivks pnjjik vr mitqnye oit hivjik ykstir lpkipvk nqjitkoik discpqicpj ivki kivdykd hyr jviesvkk ivkdidibik, oit hy oik scpnteik, scptleeik disvcpjitk hwnt kvcpj übiq anssji, slksj nbit zivkitqiv etücpji hivjvdji, wikvdsjiks zivki itetiyqvcpik. ibik ontyr wnt rnk etlp nk oik annt knttik, wiqcpi hwnt klcp sjvqq yko itksjpnej dikyd wntik, nbit olcp ivkvdi entbi yko ivkvdi diqidikpivj hy diqäcpjit yko saljj pitivkbtncpjik. wikk ivkit mlk vpkik oytcp ivkik kiyik sjtivcp mlk svcp tioik rncpji, dvkd ivk etlpis wijjitqiycpjik übit ovi enqjvdik, btnykik disvcpjit oit söpki kvrvzlks yko hyt qysj nr sanssi siqbit znr klcp nqs eivki apntvsävscpi wüthi oit dikyss oit ivdikik übitqidikpivj, wiqcpi mlt mitdküdik scpknqhji vr dieüpq, mlt slqcpik vttykdik loit eipqjtvjjik svcpit hy sivk. hy xikik mviqik, ovi vk oit rvjji hwvscpik diticpjik yko sükoitk sjnkoik yko mlk bivoik ditk ons nkkiprqvcpi rvjdiklssik päjjik, dipötji nycp rivk mnjit. is wytoi zivk knttiksjtivcp tive, oit vpk kvcpj rvj siqvdit yktypi iteüqqj päjji, yko it scpwnkzji nqsonkk hwvscpik oit jivqkiprikoik biwykoitykd eüt oik nksjvejit yko oir eivsjik biwyssjsivk oit ivdikik rnziqqlsvdzivj alssvitqvcp pvk yko wvoit."
exp.geheimnisse.push "häqals cjcc lyh jqyh jeetlk rtl axjq kjxzlkl, höxit lhxt txrjqelyhtk xtztk jk qkz hjiit wtlkt qkhtlelst axtqzt jk lhxtk vjhextlyhtk wtkcyhelyhftlitk. lhx tkislks ftlk athetx qkz ejcitx jk lhxtk käyhcitk, clt bltc lhktk lw onxjqc mtlkelyh jrcyhäivtkz lhxt meäivt lw atstatqtx jk. wlyh jrtx hjiit clt lkc htxv stcyhencctk qkz otxixjqit wlx zlt fetlkcitk txetrklcct qkz rtnrjyhiqkstk naatk qkz qwciäkzelyh jk. clt axjsit wlyh kjyh dtztw fetlktk tlkfjqa, bltolte lyh rtvjhei hjrt, qkz bjyhit zjxürtx, zjcc lyh klyhi ürtxonxitlei büxzt. clt eltcc clyh zlt etrtkceäqat ztx htlelstk txvähetk qkz wjyhit wlyh zjaüx wli ztk sthtlwklcctk ztc nrcifjqac, ztc stwücthjkztec qkz ztx füyht rtfjkki. tlktc jrtkzc cjcctk blx lk ztx strxtyhelyhtk hjeet. lyh hjiit vqw xjctkztk tkivüyftk ztx flkztx qkz wäzyhtk tlk cyhbtlvtxeltz stcqkstk qkz tlktk dnzetx encstejcctk. clt bjkztk clyh onx eqci, lwliltxitk ztk fejks ztx axtwztk cmxjyht qkz vtlsitk wlx, blt fnwlcyh wtlk fthefnma rtlw dnztek jqa qkz kltztx stciltstk ctl. zj rtsjkk dtwjkz onk ztx eltrt vq cmxtyhtk. zlt wäzyhtk flyhtxitk, axjq kjxzlkl otxzxthit zlt jqstk qkz ctqavit ctkilwtkije, qkz cyheltccelyh bjxz lyh rtciüxwi, wtlkt tlstktk eltrtcstcyhlyhitk vq txvähetk. lyh cyhblts ürtx telcjrtih, txväheit jrtx wtlkt fjhkajhxi wli ztx jseltiil qkz wtlkt otxqkseüyfit eltrtctxfeäxqks. tc bjx wlx cnkztxrjx, zltct stcyhlyhit, onk ztx lyh jqcctx xlyhjxz kltwjkztw dt tlk bnxi jkotxixjqi hjiit, kqk wtlktx ktqsltxlstk qwrxlcyhtk stcteecyhjai vq txvähetk, jkstclyhic ztx cüzelyh cyhwjetk citlktxktk sjcctk qkz ztx hüste, ürtx bteyhtk ztx xnisneztkt jrtkz zqaitit. lyh txväheit nhkt olte xtaetulnk, kjyh jxi ztx jeitk knoteetk, qkz znyh bjx wtlk htxv zjrtl qkz lyh hjiit htlwelyh aqxyhi, zlt vqhöxtx büxztk ejyhtk qkz wlyh ktyftk."
exp.geheimnisse.push "ylz vdwli wdtte low ztetz nenadmyt, eli zloweqez dmne hm wdyei miv eli nmteq yerydowteq hm zeli. yrxxl jmqve dyeq dmow vdqli feli yejmiveqteq aewqfelzteq. vd eq di veq idtmq miv idfeitalow di tleqei elie nqrzze gqemve wdtte, güwqte low lwi wämgln li vei hrrarnlzowei ndqtei. vrqt wdttei jlq ndih cöztalowe ztmivei. yrxxl cdiite idow cmqheq helt kevez eliheaie tleq miv vd jlq ztetz yqrt miv hmoceq fltyqdowtei, cdiitei fdiowe tleqe dmow miz miv jlq zowarzzei daaeqael gqemivzowdgtei. elie yezriveqe brqaleye wdttei jlq güq vei tdxlq, vezzei elihlne tmneiv elie zelieq ndttmin zrizt ilowt elneie qelialowcelt lzt. lf üyqlnei gdivei jlq lwi elineylavet, jeiln liteaalneit, migqemivalow, mivdicydq miv wöowzt negqäzzln. diveqe tleqe, idfeitalow veq eaegdit, vle qewe miv nefzei, zrndq veq qmxxlne ylzri, helntei güq vei efxgdineiei hmoceq ztetz elie nejlzze vdicydqcelt, livef zle miz eitjeveq beqtqdmalow diyaloctei rveq ez neqie vmavetei, zlow bri flq ztqeloweai hm adzzei. yelf tdxlq jdq celie zxmq vdbri. zrydav jlq li zelie iäwe cdfei, eqzowlei eq xqrfxt df nltteq, gqdzz adinzdf miv nqüivalow jdz eq bri miz eqwleat miv hrn zlow, jeii eq zdw vdzz ilowtz fewq güq lwi dyglea, rwie zdin miv cadin jleveq hmqüoc. jlq gdivei vdqli eli helowei bri ztrah miv owdqdcteq miv vd eq vdz lwf hmnevdowte jeveq eqyetteate irow vdgüq vdicte, zriveqi jle eliei zeayztbeqztäivalowei tqlymt aemtzealnzt eitneneiidwf, idiitei jlq lwi vei hraaeliiewfeq. hmjelaei eqwry zlow, vd yrxxl vle tleqe felzt ilowt zeayeq gütteqi criite, eli ztqelt vdqüyeq, ry veq tdxlq imi neimn wdye rveq ry lwf irow eli jelteqez ztüocowei hmcäfe. jlq eqjrnei vdz flt elieq zdowalowcelt miv elineweivei xqügmin, daz jäqe ez elie ztddtzdctlri. elizt jdqei jlq zowri df tdxlq brqüyeq, daz yrxxl felite, jlq wättei lwf vrow irow eli ztüoc hmoceq fewq neyei zraaei. dazr cewqtei jlq jleveq mf, veq lihjlzowei dmgz ztqrwadneq hmqüocnecewqte tdxlq dyeq yaliheate wrowfütln weqüyeq miv cdf ilowt diz nltteq. »eitzowmavlnei zle nütlnzt, weqq eliiewfeq,« qleg yrxxl lwf hm, »dyeq low nadmyte jlq wättei miz mf eliei hmoceq nelqqt.« miv jelteq nlinz hmf eaegditei, veq zowri braa eqjdqtmin wli miv weq jdtzoweate miv miz zeliei jdqfei, yejenalowei qüzzea eitnenei ztqeocte. lwi criite yrxxl zeayzt gütteqi, miv eq zdw flt clivaloweq jriie hm, jle veq qleze vei nezowfelvlnei qüzzea hm lwf weqüyeq yrn, vdz yqrt dmz zelieq gadowei wdiv dmgidwf miv miz dmz vei glveaei, jlihlnei ämnaeli zowadm miv jrwajraaeiv diyaliheate."
exp.geheimnisse.push "gu iaq par mky mjrgu kzzq kmqrl zäjwt, iqll pqal waleqr jlfqryquqly mql auraeql xqrüurt, iqll jlyqrq wüyyq yagu jltqr mqp tayguq xqeqelql! agu saquq sjrügo iaq fnp wqjqr, jlm qalq equqapq orkwt saqut pagu iaqmqr fnriärty--par iarm'y yn yguialmqzae fnr kzzql yallql.--n! jlm aurq jlygujzm, aurq jlxqwkleqlq yqqzq wüuzt lagut, iaq yqur pagu maq ozqalql fqrtrkjzaguoqatql bqalaeql. iqll yaq ekr ap eqybrägu aurq uklm kjw maq pqalaeq zqet jlm ap altqrqyyq mqr jltqrrqmjle läuqr sj par rügot, mkyy mqr uappzayguq ktqp aurqy pjlmqy pqalq zabbql qrrqaguql okll:--agu ezkjxq sj fqryaloql, iaq fnp iqttqr eqrüurt.--jlm, iazuqzp! iqll agu pagu dqpkzy jltqrytquq, maqyql uappqz, maqyqy fqrtrkjql--! mj fqrytquyt pagu. lqal, pqal uqrs ayt yn fqrmqrxt lagut! yguikgu! yguikgu eqlje!--jlm ayt mky lagut fqrmqrxql?--yaq ayt par uqazae. kzzq xqeaqr yguiqaet al aurqr eqeqlikrt. agu iqayy laq, iaq par ayt, iqll agu xqa aur xal; qy ayt, kzy iqll maq yqqzq yagu par al kzzql lqrfql jpoqurtq.--yaq ukt qalq pqznmaq, maq yaq kjw mqp ozkfaqrq ybaqzqt pat mqr orkwt qalqy qleqzy, yn yapbqz jlm yn eqaytfnzz! qy ayt aur zqaxzaqm, jlm pagu ytqzzt qy fnl kzzqr bqal, fqriarrjle jlm erazzql uqr, iqll yaq ljr maq qrytq lntq mkfnl erqawt."
exp.geheimnisse.push "uy eya uex cxwrüvk, berfuri, iuexu aäaewux knäoau yexl qc uexun cxncfewux räyyewkuea zunyaeiia, evf kpxx xevfa iüyyew yuex cxl kpxx ljvf pcvf xevfay acx. evf fptu kuexu zjnyaurrcxwyknpoa, kuex wuoüfr px lun xpacn, cxl leu tüvfun ukurx ievf px. buxx ben cxy yurtya oufrux, oufra cxy ljvf prruy. evf yvfbönu len, ipxvfipr büxyvfau evf, uex apwuröfxun qc yuex, ci xcn luy ijnwuxy tuei unbpvfux uexu pcyyevfa pco lux küxoaewux apw, uexux lnpxw, uexu fjooxcxw qc fptux. joa tuxuelu evf prtunaux, lux evf ütun leu jfnux ex pkaux tuwnptux yufu, cxl terlu ien uex, ien bänu bjfr, buxx evf px yuexun yaurru bänu! yvfjx uarevfuipr eya ien'y yj pcowuopfnux, evf bjrrau len yvfnuetux cxl lui iexeyaun, ci leu yaurru tue lun wuypxlayvfpoa pxqcfpraux, leu, beu lc zunyevfunya, ien xevfa zunypwa bunlux bünlu. evf wrpctu uy yurtya. lun iexeyaun reuta ievf yuea rpxwun quea, fpaau rpxwu ien pxwuruwux, evf yjrrau ievf enwuxluexui wuyvfäoau beliux; cxl uexu yacxlu eya ien'y pcvf bjfr lnci qc acx. funxpvf, buxx evf beulun lnpx luxku cxl ien leu optur zji hounlu uexoärra, lpy, yuexun onuefuea cxwulcrlew, yevf ypaaur cxl qucw pcoruwux räyya cxl qcyvfpxlux wuneaaux benl--evf bueyy xevfa, bpy evf yjrr.--cxl, iuex reutun! eya xevfa zeurruevfa lpy yufxux ex ien xpvf zunäxluncxw luy qcyapxly uexu exxunu, cxtufpwrevfu cxwulcrl, leu ievf ütunprrfex zunojrwux benl?"
exp.geheimnisse.push "kmvr irvnvc shrnv pknnvu wzv jfnnvr vrcn rvqpn mvfurfpzin, czv nrkn tfr cvznv, vrmlzqynv wvu rzvczivu mrkfuvu alvqy kfa wvr ivmlüjnvu nkxvnv, rzva, vpv zpr vzivunlzqp tfj mvsfccncvzu ykj, wkcc wkc irvihr skr, skc czv ckp, jzn cqprvzvuwvr, rkfpvr cnzjjv: »kqp ihnn, kqp ihnn!« fuw azvl jzn kfcivmrvznvnvu krjvu, klc ivmv czv kllvc kfa, ümvr wkc ykukxvv pzu fuw rüprnv czqp uzqpn. »wf, irvihr!« rzva wzv cqpsvcnvr jzn vrphmvuvr akfcn fuw vzuwrzuilzqpvu mlzqyvu. vc skrvu cvzn wvr bvrskuwlfui wzv vrcnvu shrnv, wzv czv fujznnvlmkr ku zpu ivrzqpnvn pknnv. czv lzva zuc uvmvutzjjvr, fj zrivuwvzuv vccvut tf phlvu, jzn wvr czv wzv jfnnvr kfc zprvr hpujkqpn svqyvu yöuunv; irvihr shllnv kfqp pvlavu -- tfr rvnnfui wvc mzlwvc skr uhqp tvzn --; vr ylvmnv kmvr avcn ku wvj ilkc fuw jfccnv czqp jzn ivskln lhcrvzccvu; vr lzva wkuu kfqp zuc uvmvutzjjvr, klc yöuuv vr wvr cqpsvcnvr zrivuwvzuvu rkn ivmvu, szv zu arüpvrvr tvzn; jfccnv kmvr wkuu funänzi pzunvr zpr cnvpvu; säprvuw czv zu bvrcqpzvwvuvu aläcqpqpvu yrkjnv, vrcqprvqynv czv uhqp, klc czv czqp fjwrvpnv; vzuv alkcqpv azvl kfa wvu mhwvu fuw tvrmrkqp; vzu cxlznnvr bvrlvntnv irvihr zj ivczqpn, zrivuwvzuv äntvuwv jvwztzu fjalhcc zpu; irvnv ukpj ufu, hpuv czqp läuivr kfatfpklnvu, ch bzvlv aläcqpqpvu, klc czv ufr pklnvu yhuunv, fuw rkuunv jzn zpuvu tfr jfnnvr pzuvzu; wzv nür cqplfi czv jzn wvj afccv tf. irvihr skr ufu bhu wvr jfnnvr kmivcqplhccvu, wzv wfrqp cvzuv cqpflw bzvllvzqpn wvj nhwv ukpv skr; wzv nür wfranv vr uzqpn öaauvu, shllnv vr wzv cqpsvcnvr, wzv mvz wvr jfnnvr mlvzmvu jfccnv, uzqpn bvrgkivu; vr pknnv gvntn uzqpnc tf nfu, klc tf skrnvu; fuw bhu cvlmcnbhrsüravu fuw mvchriuzc mvwräuin, mvikuu vr tf yrzvqpvu, ümvryrhqp kllvc, säuwv, jömvl fuw tzjjvrwvqyv fuw azvl vuwlzqp zu cvzuvr bvrtsvzalfui, klc czqp wkc ikutv tzjjvr cqphu fj zpu tf wrvpvu kuazui, jznnvu kfa wvu irhccvu nzcqp."
exp.geheimnisse.push "pmzvlvdu yhmzf zt fvduj wzum gvz lzruhpjzf sfjzmuhljsfazf gzm pmüuzmzf ozvjzf, hf gvz amzacm vf gzf klzvfzf ucjzlovwwzmf tjzjt wvj zvfvazw ezmlhfazf azghduj uhjjz, yzff zm tvdu wügz vf ght pzsdujz rzjjozsa uhjjz yzmpzf wüttzf. zt avfa nzjoj wzvtj fsm tzum tjvll os. gzm ehjzm tdulvzp rhlg fhdu gzw fhdujzttzf vf tzvfzw tzttzl zvf; gvz wsjjzm sfg tduyztjzm zmwhufjzf zvfhfgzm osm tjvllz; gvz wsjjzm fäujz, yzvj ürzm ght lvduj ecmazrzsaj, pzvfz yätduz püm zvf wcgzfaztduäpj; gvz tduyztjzm, gvz zvfz tjzllsfa hlt ezmkäspzmvf hfazfcwwzf uhjjz, lzmfjz hw hrzfg tjzfcamhquvz sfg pmhfoötvtdu, sw evzllzvduj tqäjzm zvfwhl zvfzf rzttzmzf qctjzf os zmmzvduzf. whfduwhl yhdujz gzm ehjzm hsp, sfg hlt yvttz zm ahm fvduj, ghtt zm aztdulhpzf uhrz, thajz zm osm wsjjzm: »yvz lhfaz gs uzsjz tducf yvzgzm fäutj!« sfg tdulvzp tcpcmj yvzgzm zvf, yäumzfg wsjjzm sfg tduyztjzm zvfhfgzm wügz osläduzljzf."
exp.geheimnisse.push "tovz cvjocy xvmm shv clgxvcyvz, vzclgöuny aim hgzvz ovzknctzovhy, svccvm üovzszücchp pvxizsvm xtz, nüz pzvpiz, xhv nzügvz, fk cizpvm, ci gäyyv milg bvhmvcxvpc shv ekyyvz nüz chv vhmyzvyvm eüccvm kms pzvpiz gäyyv silg mhlgy avzmtlgjäcchpy fk xvzsvm oztklgvm. svmm mkm xtz shv ovshvmvzhm st. shvcv tjyv xhyxv, shv hm hgzve jtmpvm jvovm ehy ghjnv hgzvc cytzbvm bmilgvmotkvc stc äzpcyv üovzcytmsvm gtovm eilgyv, gtyyv bvhmvm vhpvmyjhlgvm toclgvk aiz pzvpiz. igmv hzpvmsxhv mvkphvzhp fk cvhm, gtyyv chv fknäjjhp vhmetj shv yüz aim pzvpizc fheevz tknpvetlgy kms xtz he tmojhlb pzvpizc, svz, pämfjhlg üovzztclgy, yziyfsve hgm mhvetms rtpyv, ghm- kms gvzfkjtknvm ovptmm, shv gämsv he clgicc pvntjyvy cytkmvms cyvgvm pvojhvovm. cvhysve avzcäkeyv chv mhlgy, cyvyc njülgyhp eizpvmc kms tovmsc shv yüz vhm xvmhp fk önnmvm kms fk pzvpiz ghmvhmfkclgtkvm. tmntmpc zhvn chv hgm tklg fk chlg gvzovh, ehy xizyvm, shv chv xtgzclgvhmjhlg nüz nzvkmsjhlg ghvjy, xhv »biee etj gvzüovz, tjyvz ehcybänvz!« isvz »cvgy etj svm tjyvm ehcybänvz!« tkn cijlgv tmcuztlgvm tmyxizyvyv pzvpiz ehy mhlgyc, cimsvzm ojhvo kmovxvpjhlg tkn cvhmve ujtyf, tjc cvh shv yüz ptz mhlgy pvönnmvy xizsvm. gäyyv etm silg shvcvz ovshvmvzhm, cytyy chv mtlg hgzvz jtkmv hgm mkyfjic cyözvm fk jtccvm, jhvovz svm ovnvgj pvpvovm, cvhm fheevz yäpjhlg fk zvhmhpvm! vhmetj te nzügvm eizpvm -- vhm gvnyhpvz zvpvm, ahvjjvhlgy clgim vhm fvhlgvm svc bieevmsvm nzügrtgzc, clgjkp tm shv clgvhovm -- xtz pzvpiz, tjc shv ovshvmvzhm ehy hgzvm zvsvmctzyvm xhvsvz ovptmm, svztzyhp vzohyyvzy, stcc vz, xhv fke tmpzhnn, tjjvzshmpc jtmpcte kms ghmnäjjhp, chlg pvpvm chv xvmsvyv. "
exp.geheimnisse.push "rvu ovccl jigo vuylböouc, siuyl, sil rvu vuslmjbe uigoc quclmzmiuylu weuucl, iu siljlj tirrlm oiuliutqjclpplu, qus jepgolm siuyl yvz lj uqu kilpl, sv rvu liu tirrlm slm beouquy vu smli tirrlmolmmlu klmrilclc ovccl. siljl lmujclu olmmlu, -- vppl smli ovcclu keppzämcl, bil ymlyem liurvp sqmgo liul cümjavpcl hljcjclppcl -- bvmlu aliupigo vqh emsuquy, uigoc uqm iu iomlr tirrlm, jeuslmu, sv jil jigo uqu liurvp oilm liuylrilclc ovcclu, iu slm yvutlu bimcjgovhc, vpje iujzljeuslml iu slm wügol, zlsvgoc. quuüctlu eslm yvm jgorqctiylu wmvr lmcmqylu jil uigoc. üzlmsilj ovcclu jil tqr ymöjjclu clip ioml liylulu liumigocquyjjcügwl ricylzmvgoc. vqj siljlr ymqusl bvmlu kilpl siuyl üzlmhpüjjiy ylbemslu, sil tbvm uigoc klmwäqhpigo bvmlu, sil rvu vzlm vqgo uigoc blyblmhlu beppcl. vppl siljl bvuslmclu iu ymlyemj tirrlm. lzluje vqgo sil vjgoluwijcl qus sil vzhvppwijcl vqj slm wügol. bvj uqm ir vqyluzpigw quzmvqgozvm bvm, jgoplqslmcl sil zlsilulmiu, sil lj irrlm jlom lipiy ovccl, liuhvgo iu ymlyemj tirrlm; ymlyem jvo ypügwpigolmblijl rlijc uqm slu zlcmlhhluslu ylylujcvus qus sil ovus, sil iou oilpc. sil zlsilulmiu ovccl kilppligoc sil vzjigoc, zli tlic qus ylplyluolic sil siuyl bilslm tq oeplu eslm vppl iujyljvrc ric liulrrvp oiuvqjtqblmhlu, cvcjägopigo vzlm zpilzlu jil semc pilylu, beoiu jil sqmgo slu lmjclu bqmh ylwerrlu bvmlu, bluu uigoc ymlyem jigo sqmgo svj mqralptlqy bvus qus lj iu zlblyquy zmvgocl, tqlmjc yltbquylu, blip wliu jeujciylm apvct tqr wmilgolu hmli bvm, jaäclm vzlm ric bvgojluslr klmyuüylu, ezbeop lm uvgo jepgolu bvuslmquylu, tqr jclmzlu rüsl qus cmvqmiy, bilslm jcquslupvuy jigo uigoc müomcl."
exp.geheimnisse.push "dgvrmg rc msgzgo rhgcm -- dvgdav gvsccgvug zspt csptu, yätvgcm mgv drcxgc xgsu msg isajscg dgtövu xe trhgc -- gvuöcug zsg iac mgv nüptg tgv. msg xsoogvtgvvgc truugc zptac stv crptuortj hggcmgu, mgv osuujgvg truug gscg xgsuecd tgviavdgxadgc, mgc xygs rcmgvgc bg gsc hjruu dgdghgc, ecm cec jrzgc zsg xevüpndgjgtcu ecm vreptugc. rjz msg isajscg xe zlsgjgc hgdrcc, yevmgc zsg reqogvnzro, gvtahgc zspt ecm dscdgc req mgc qezzzlsuxgc xev iavxsoogvuüv, sc mgv zsg rcgscrcmgvdgmväcdu zugtgc hjsghgc. orc oezzug zsg iac mgv nüptg rez dgtövu trhgc, mgcc mgv irugv vsgq: »szu mgc tgvvgc mrz zlsgj isgjjgsptu ecrcdgcgto? gz nrcc zaqavu gscdgzugjju ygvmgc.« »so dgdgcugsj,« zrdug mgv osuujgvg mgv tgvvgc, »oöptug mrz qväejgsc csptu xe ecz tgvgscnaoogc ecm tsgv so xsoogv zlsgjgc, ya gz mapt isgj hgfegogv ecm dgoüujsptgv szu?« »a hsuug,« vsgq mgv irugv, rjz zgs gv mgv isajsczlsgjgv. msg tgvvgc uvrugc scz xsoogv xevüpn ecm yrvugugc. hrjm nro mgv irugv osu mgo caugcleju, msg oeuugv osu mgc caugc ecm msg zptygzugv osu mgv isajscg. msg zptygzugv hgvgsugug rjjgz vetsd xeo zlsgjg iav; msg gjugvc, msg csgorjz qvütgv xsoogv igvosgugu truugc ecm mgztrjh msg töqjsptngsu dgdgc msg xsoogvtgvvgc ühgvuvsghgc, yrdugc drv csptu, zspt req stvg gsdgcgc zgzzgj xe zguxgc;"
exp.geheimnisse.push "ceu nyomunauj lubfqq ts nveuiuq; pfauj sqc zsaauj pujxkibauq, hucuj pkq nuequj nueau, fsxzujdnfz ceu lumubsqbuq eojuj oäqcu. bjubkj ofaau, pkq cuz nveuiu fqbutkbuq, neyo ueq muqeb mueauj pkjbumfba sqc mfj nyokq zea cuz dkvx ez mkoqtezzuj. uj msqcujau neyo dfsz cfjüluj, cfnn uj eq iuatauj tuea nk muqeb jüydneyoa fsx ceu fqcujq qfoz; xjüouj mfj ceunu jüydneyoaqfozu nueq nakit bumunuq. sqc cflue oäaau uj bujfcu huata zuoj bjsqc buofla, neyo ts pujnauyduq, cuqq eqxkibu cun nafslun, cuj eq nuequz tezzuj ülujfii ifb sqc lue cuj diueqnauq lumubsqb szoujxikb, mfj fsyo uj bfqt nafsllucuyda; xäcuq, offju, nvuenuülujjunau nyoiuvvau uj fsx nuequz jüyduq sqc fq cuq nueauq zea neyo oujsz; nuequ biueyobüiaebduea bubuq fiiun mfj peui ts bjknn, fin cfnn uj neyo, meu xjüouj zuojzfin mäojuqc cun afbun, fsx cuq jüyduq buiuba sqc fz auvveyo bunyousuja oäaau. sqc ajkat ceunun tsnafqcun ofaau uj duequ nyous, ueq naüyd fsx cuz zfduiiknuq xsnnlkcuq cun mkoqtezzujn pkjtsjüyduq."
exp.geheimnisse.push "»mrww pabpa!« wtrc vrw btjjurwr mrww vrb zajrw eg gnv ertljr, omnr rtn yrtjrwrp yowj eg zrwutrwrn, btj vrb ertlrctnlrw agc vrn uanlpab pthm zowyäwjpiryrlrnvrn lwrlow. vtr ztoutnr zrwpjgbbjr, vrw btjjurwr etbbrwmrww uähmrujr rwpj rtnbau xoscphmüjjrunv prtnrn cwrgnvrn eg gnv pam vann ytrvrw agc lwrlow mtn. vrw zajrw phmtrn rp cüw nöjtlrw eg maujrn, pjajj lwrlow eg zrwjwrtirn, zowrwpj vtr etbbrwmrwwrn eg irwgmtlrn, jwojevrb vtrpr law nthmj agclrwrlj yawrn gnv lwrlow ptr brmw aup vap ztoutnpstru eg gnjrwmaujrn phmtrn. rw rtujr eg tmnrn gnv pghmjr ptr btj agplriwrtjrjrn awbrn tn tmw etbbrw eg vwänlrn gnv lurthmertjtl btj prtnrb xöwsrw tmnrn vrn agpiuthx agc lwrlow eg nrmbrn. ptr ygwvrn ngn jajpähmuthm rtn yrntl iöpr, ban ygppjr nthmj brmw, oi üirw vap irnrmbrn vrp zajrwp ovrw üirw vtr tmnrn drjej agclrmrnvr rwxrnnjntp, omnr rp eg ytpprn, rtnrn pouhmrn etbbrwnahmiaw ytr lwrlow irprpprn eg mairn. ptr zrwuanljrn zob zajrw rwxuäwgnlrn, moirn tmwrwprtjp vtr awbr, egscjrn gnwgmtl an tmwrn iäwjrn gnv ythmrn ngw uanlpab lrlrn tmw etbbrw egwühx. tneytphmrn majjr vtr phmyrpjrw vtr zrwuowrnmrtj, tn vtr ptr nahm vrb suöjeuthm ailriwohmrnrn pstru zrwcauurn yaw, üirwygnvrn, majjr pthm, nahmvrb ptr rtnr ertjuanl tn vrn uäpptl mänlrnvrn mänvrn ztoutnr gnv iolrn lrmaujrn gnv yrtjrw, aup pstrur ptr nohm, tn vtr nojrn lrprmrn majjr, btj rtnrb baur agclrwaccj, majjr vap tnpjwgbrnj agc vrn phmopp vrw bgjjrw lrurlj, vtr tn ajrbirphmyrwvrn btj mrcjtl awirtjrnvrn ugnlrn nohm agc tmwrb prppru papp, gnv yaw tn vap nrirnetbbrw lruagcrn, vrb pthm vtr etbbrwmrwwrn gnjrw vrb vwänlrn vrp zajrwp phmon phmnruurw nämrwjrn."
exp.geheimnisse.push "zjs fhkjs nhdikj aek khckjdzjd gädzjd rb cjedja cjccjv bdz vejcc celg gedjeduhvvjd; jc chg hbc, hvc cksjlij js celg rb cjedja ojnögdvelgjd hxjdzclgväulgjd, hxjs zhc ckhsij delijd cjedjc nej ghvkvtcjd itqujc rjeokj, zhcc js ohdr bdz ohs delgk clgveju. osjots nhs zej ohdrj rjek ckevv hbu zja qvhkr ojvjojd, hbu zja egd zej reaajsgjssjd jskhqqk ghkkjd. zej jdkkäbclgbdo üxjs zhc aeccvedojd cjedjc qvhdjc, fejvvjelgk hxjs hblg zej zbslg zhc fejvj gbdojsd fjsbschlgkj clgnälgj ahlgkjd jc ega bdaöovelg, celg rb xjnjojd. js uüslgkjkj aek jedjs ojneccjd xjckeaakgjek clgtd uüs zjd dälgckjd hbojdxveli jedjd hvvojajedjd üxjs egd celg jdkvhzjdzjd rbchaajdckbsr bdz nhskjkj. delgk jedahv zej fetvedj clgsjlikj egd hbu, zej, bdkjs zjd rekkjsdzjd uedojsd zjs abkkjs gjsfts, egs fta clgtccj uejv bdz jedjd ghvvjdzjd ktd ftd celg ohx"
exp.geheimnisse.push "»xqf tudd qd,« jaqc paq dmgxqdsqj, »prd ads prd qalzafq tassqo, yrsqj. pu tudds novdd pql fqprleql ovdzuxqjpql dumgql, prdd qd fjqfvj ads. prdd xaj qd dv orlfq fqforuns grnql, prd ads kr uldqj qafqlsoamgqd ulfoüme. rnqj xaq erll qd pqll fjqfvj dqal? xqll qd fjqfvj xäjq, qj gässq oälfds qalfqdqgql, prdd qal zudrttqloqnql yvl tqldmgql tas qalqt dvomgql saqj lamgs töfoamg ads, ulp xäjq cjqaxaooaf cvjsfqfrlfql. xaj gässql prll eqalql njupqj, rnqj eöllsql xqasqj oqnql ulp dqal rlpqleql al qgjql grosql. dv rnqj yqjcvofs uld paqdqd saqj, yqjsjqans paq zattqjgqjjql, xaoo vccqlnrj paq frlzq xvglulf qallqgtql ulp uld ruc pqj frddq ünqjlrmgsql orddql. daqg luj, yrsqj,« dmgjaq daq woöszoamg ruc, »qj cälfs dmgvl xaqpqj rl!« ulp al qalqt cüj fjqfvj fälzoamg ulyqjdsälpoamgql dmgjqmeql yqjoaqdd paq dmgxqdsqj dvfrj paq tussqj, dsaqdd damg cöjtoamg yvl agjqt dqddqo rn, rod xvoosq daq oaqnqj paq tussqj vwcqjl, rod al fjqfvjd lägq noqanql, ulp qaosq galsqj pql yrsqj, pqj, oqpafoamg pujmg agj nqlqgtql qjjqfs, rumg rucdsrlp ulp paq rjtq xaq zut dmguszq pqj dmgxqdsqj yvj agj gron qjgvn."
exp.geheimnisse.push "egj ec atüryf cbtoyf sqy wysqyfytqf lec -- dbt gekvyt lteav kfs yqgy jurgko jqy, mqy bav cef jqy ekur jurbf oywyvyf revvy, sej zk dytcyqsyf, eggy vütyf sytetvqo zk, sejj qf syt oefzyf mbrfkfo dbf qrtyc lbccyf ef lyqf tkrqoyt jurgea cyrt cöogqur met --, aefs jqy wyq qrtyc oymörfgquryf lktzyf wyjkur wyq otyobt zkytjv fqurvj wyjbfsytyj. jqy seurvy, yt gqyoy ewjqurvgqur jb kfwymyogqur se kfs jnqygy syf wygyqsqovyf; jqy vtekvy qrc eggyf cöogquryf dytjvefs zk. myqg jqy zkaäggqo syf gefoyf wyjyf qf syt refs rqygv, jkurvy jqy cqv qrc otyobt dbf syt vüt ekj zk lqvzygf. egj jqur ekur se lyqf ytabgo zyqovy, mktsy jqy ätoytgqur kfs jvqyjj yqf myfqo qf otyobt rqfyqf, kfs ytjv egj jqy qrf brfy hysyf mqsytjvefs dbf jyqfyc ngevzy oyjurbwyf revvy, mktsy jqy ekacytljec. egj jqy wegs syf mertyf jeurdytregv ytleffvy, ceurvy jqy otbjjy ekoyf, naqaa dbt jqur rqf, rqygv jqur ewyt fqurv gefoy eka, jbfsytf tqjj sqy vüt syj jurgeazqccytj eka kfs tqya cqv gekvyt jvqccy qf sej skflyg rqfyqf: »jyryf jqy fkt ceg ef, yj qjv ltynqytv; se gqyov yj, oefz kfs oet ltynqytv!«"
exp.geheimnisse.push "boi ribgxhubbiz, tiz xicjofiz jnf qcv ncblcxiz czt bynqoilizfixiz qc dilkiztiz; boi xnjjiz toibi nlriojbczjilrligxczf zogxj zcl diltoizj, boi rlncgxjiz boi bufnl czritozfj. czt bu bijqjiz boi bogx qcv jobgx czt bgxloiriz tlio izjbgxchtofczfbrloipi, xill bnvbn nz biozi toliejouz, plnc bnvbn nz oxliz ncpjlnffiril, czt fliji nz oxliz ylozqoynh. käxlizt tib bgxliorizb env toi ritoiziloz xilioz, cv qc bnfiz, tnbb boi puljfixi, tizz oxli vulfiznlrioj knl riiztij. toi tlio bgxlioriztiz zogejiz qcilbj rhubb, uxzi ncpqcbgxnciz, ilbj nhb toi ritoiziloz bogx ovvil zugx zogxj izjpilziz kuhhji, bnx vnz älfilhogx ncp. »zcz?« plnfji xill bnvbn. toi ritoiziloz bjnzt hägxihzt oz til jül, nhb xnri boi til pnvohoi ioz flubbib fhüge qc vihtiz, kilti ib nril zcl tnzz jcz, kizz boi flüzthogx ncbfiplnfj kilti. toi pnbj ncpligxji ehiozi bjlncbbpitil ncp oxliv xcj, üril toi bogx xill bnvbn bgxuz käxlizt oxlil fnzqiz toizbjqioj älfilji, bgxknzeji hiogxj zngx nhhiz logxjczfiz. »nhbu knb kuhhiz boi iofizjhogx?« plnfji plnc bnvbn, dul kihgxil toi ritoiziloz zugx nv viobjiz libyiej xnjji."
exp.geheimnisse.push "apoboi yel deyyo pilowa opw opb pw jopwoj zocow locismdow. aoww wtw rej opw oioplwpb tj aeb ewaoio. ktwämdby wedj jew jpmd aob öqyoiow etq coilqediyow jpy, etmd etq bmdfpoiploio, twa pmd aiewl jpy bswaoicei corzsjjowoi fszztby pw apo lisbbow lodopjwpbbo aoi dödow opw. aeietq feia pmd ktj lepbdpiyow oiwewwy. ew opwoi nsw aow dezaow, fsdpw pmd lofödwzpmd jopwo ypoio yipoc, lec ob opwow fpwalobmdüykyow fpwroz, nsw rscezyczetoj owkpew twa dozzisyoj byopwciomd ücoiftmdoiy, aeb fei jpi aoi zpocbyo uzeyk pw aoi fozy. aeb asiq fei nsw asiy etb twbpmdycei twa etmd nsj boo fei wti ücoi qozbow fol opw bmdjezoi, czewroi byiopqow kt oiczpmrow, aeqüi ciewwyow apo cztjow pw zemdowa qipbmdow qeicow, aoi czeto dpjjoz zel fpo opw kozyaemd etq aow bupykplow bmdwoolpuqozw twa wocow aoj qopwow lozäty aoi kpolowlzsmrow yöwyo twtwyoicismdow aoi wpmdy fopy owyqoiwyo febboiqezz. asiy zel pmd pw aoi fäijo, byetwyo aow fopbbow fözrzopw wemd twa gsaozyo dezczety nsi jpmd dpw, cpb apo lepbow jopwo yiäldopy cojoiryow twa bpmd ezzoizop noicsyowo byiopmdo twa ztbyceiropyow zopbyow fszzyow. ob lec aecop lzopmd pw aow oibyow fsmdow opwow doicow ipbb pw jopwo udäerowdoiizpmdropy, ezb pmd jpy opwoi noizetqowow lepb ktbejjow pw opwo rzejj ecbyüikyo."
exp.geheimnisse.push "xi toxbfxztzzfz ohv kpz fphfk hfofh qwfpvf rfdxidbz zdtz pum vpf dfpxf phx wfnfh th. vpf fwzfdwpumfh btnfh mtnfh xpum nfjämdz, vfhh pum bphb ohv xzthv ph vfd jfwz xfpzmfd toy fpbfhfh yüxxfh. vfhhium koxx pdbfhv fzjtx bfyfmwz mtnfh, vtx toum vpf jpxxfhxumtyz ohv vtx jfwzwfnfh kpd hpkkfd fphndtumzf. vfhh pum qthh mfozf hium jpf lf fphfh nfdb sjphbfh, sfmh xzohvfh ktdxumpfdfh ivfd dovfdh ohv hözpbfhytwwx fphfh kthh ydfpmähvpb fdxumwtbfh, sok wfnfhxqühxzwfd tnfd yfmwz kpd mfozf hium xi rpfw jpf vtktwx. vfd ydümf fphxfpzpbf okbthb kpz vfd fdvf ohv pmdfh eywthsfh ohv zpfdfh mtzzf jfhpb xisptwf yämpbqfpzfh ph kpd toyqikkfh wtxxfh ohv hium lfzsz xphv kfphf zdäokf fph kfdqjüdvpbfd nfjfpx vtyüd, jpf xfmd pum wfpvfd fphfk dfph thpktwpxumfh wfnfh sohfpbf. pum zdäokf häkwpum xfmd iyz, pum wpfbf tk kffdfxxzdthv twx zpfd, sokfpxz twx xffmohv, ohv fkeyphvf vtnfp fph xi bfjtwzpbfx jimwnfmtbfh, vtxx pum nfpk fdjtumfh vfh jpfvfdnfxpzs kfphfd kfhxumfhjüdvf qfphfxjfbx ydfovpb ivfd kpz xziws, xihvfdh wfvpbwpum kpz nfvtofdh jtmdhfmkf."

# End Geheimnisse
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

bt = document.getElementById "btn_next_Problem"
bt.onclick = (e) ->
	exp.newProblem()
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
	if src.value == " "
		src.value = ""
	exp.checkunique(src.id,src.value)
	exp.decrypt()






