

# document.body.appendChild(cartDiv)
# rpdiv = document.createElement("div")
# rp.id = '_rp'
# 

window.onload = () ->
	window.clicked = ''
	rpdiv = document.createElement('div');
	document.body.appendChild(rpdiv)
	rpdiv.id = '_rp'


	rpdiv.style.lineHeight = '10px'
	rpdiv.style.fontSize = '10px'
	rpdiv.style.padding = '0'
	rpdiv.style.margin = '0'

	rpdiv.innerHTML = "<p id='_rp'>Hello RP!</p>";
	rp = document.getElementById('_rp')
	rp.style.color           = '#6F3' #green
	rp.style.backgroundColor = '#333' #darkgrey
	rp.style.padding         = '2px'
	rp.style.position        = 'fixed'
	rp.style.bottom          = '0px'
	rp.style.lineHeight      = '10px'
	rp.style.fontSize        = '10px'
	# rp.style.padding = '0'
	rp.style.margin = '0'

	setInterval ->
		d = new Date()
		# hh = d.getHours()
		# mm = d.getMinutes()
		# ss = d.getSeconds()
		# ms = d.getMilliseconds()
		# ms = Math.floor(ms/100)
		# clock = "#{hh}:#{mm}:#{ss}:#{ms}"
		clock = d.toLocaleTimeString()
		w = window.innerWidth
		h = window.innerHeight
		t = document.body.scrollTop
		# console.log "Top: #{document.body.scrollTop}"
		bw = document.documentElement.clientWidth
		rpdiv.innerHTML = "Debug: #{clock} | W:#{w} | H:#{h} | T:#{t} | [#{bw}] | #{window.clicked}"
	, 50

	document.onclick = (evt) ->
	    evt = (evt || event);
	    window.clicked = "Click= x:#{evt.clientX} y:#{evt.clientY}"
	# window.onscroll = scroll
 	
	# scroll = () ->
	# 	console.log("scroll event detected! " + window.pageXOffset + " " + window.pageYOffset)
	# note: you can use window.innerWidth and window.innerHeight to access the width and height of the viewing area

# basic browser detection. see: http://stackoverflow.com/a/2401861/1148249

navigator.sayswho = () ->
	N = navigator.appName 
	ua = navigator.userAgent #, tem
	M = ua.match(/(opera|chrome|safari|firefox|msie)\/?\s*(\.?\d+(\.\d+)*)/i)
	# if(M && (tem = ua.match(/version\/([\.\d]+)/i))!= null) 
	# 	M[2]= tem[1]
	# M = M? [M[1], M[2]]: [N, navigator.appVersion,'-?']
	return M


console.log " |::| RedPill Loaded |::| "
# console.log "Top: #{document.documentElement.scrollTop} | Height: #{window.innerHeight} | Width: #{window.innerWidth} | Left: #{(window.innerWidth - 980 )/2}"


