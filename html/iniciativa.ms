<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="utf-8">
		<title>Iniciativa {{número}} — La Nación</title>
		<link rel="stylesheet" href="css/iniciativa.css">
		<meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
	</head>
	<body>
		<header class="app">
			<h1><a href="./">Iniciativas</a></h1>
			<p><img alt="La Nación" src="img/nacion-logo.svg" onerror="this.src = this.src.replace('.svg', '.png');" class="logo"></p>
			<form class="search" action="./">
				<input type="search" name="q" class="q" placeholder="Buscar">
			</form>
		</header>
		<article class="initiative">
			<h1><a href="{{número}}.html">{{tipo}}</a></h1>
			<p>Iniciativa presentada por <span class="proponent">{{proponente}}</span> en <span class="year">{{año}}</span>.</p>
			{{#trámite}}
			{{#url}}
			<p class="status"><a href="{{url}}">{{trámite}}</a></p>
			{{/url}}
			{{^url}}
			<p class="status">{{trámite}}</p>
			{{/url}}
			{{/trámite}}
			{{{asunto}}}
		</article>
	</body>
	<script>
		var _google_analyticPath = 'uid.iniciativas';
		var _gaq = _gaq || [];
		_gaq.push(['_setAccount', 'UA-1513600-1']);
		if (_google_analyticPath != '') {
			_gaq.push(['_setCustomVar', 1, 'AnalyticPath', _google_analyticPath, 3]);
		}

		_gaq.push(['_trackPageview']);
		(function(){var a=document.createElement('script');a.async=true;a.src=('https:'==document.location.protocol?'https://ssl':'http://www')+'.google-analytics.com/ga.js';var b=document.getElementsByTagName('script')[0];b.parentNode.insertBefore(a,b)})();
	</script>
</html>
