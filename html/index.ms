<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="utf-8">
		<title>Iniciativas — La Nación</title>
		<link rel="stylesheet" href="css/index.css">
		<script src="js/index.js" async></script>
		<meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
	</head>
	<body>
		<header class="app">
			<h1><a href="./">Iniciativas</a></h1>
			<p><img alt="La Nación" src="img/nacion-logo.svg" onerror="this.src = this.src.replace('.svg', '.png');" class="logo"></p>
			<form class="search">
				<input type="search" name="q" class="q" placeholder="Filtrar">
				<p class="total">{{initiatives.length}} iniciativas</p>
			</form>
		</header>
		<article class="index">
			<p>Consulte las propuestas de ley y sugerencias que en 14 años han presentado 1138 personas u organizaciones ante la Oficina de Iniciativa Popular de la Asamblea Legislativa.</p>
			<p>Esa oficina se creó en 1999 para que cualquier persona, no importa su edad, nacionalidad o nivel de educación, pueda presentar sus ideas a los diputados.</p>
			<p>Lea la nota: <a target="_blank" href="http://www.nacion.com/data/leyes-nace-propuesta-ciudadanos_0_1364263590.html">Una de cada 100 leyes nace a propuesta de ciudadanos</a>.</p>
			<p>Descarga los datos: <a href="./data/iniciativas.csv" title="Base de datos de iniciativas en formato CSV">CSV</a> o <a href="./data/iniciativas.json" title="Base de datos de iniciativas en formato JSON">JSON</a>.</p>
		</article>
		<nav class="index">
			<ul>
				{{#initiatives}}
				<li data-id="{{número}}">
					<h2><a href="{{número}}.html">{{tipo}}</a></h2>
					<p>Iniciativa presentada por {{proponente}} en {{año}}.</p>
				</li>
				{{/initiatives}}
			</ul>
		</nav>
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
