<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="utf-8">
		<title>Iniciativa {{número}} — La Nación</title>
		<link rel="stylesheet" href="css/iniciativa.css">
	</head>
	<body>
		<header class="app">
			<h1><a href="./">Iniciativas</a></h1>
			<p><img alt="La Nación" src="img/nacion-logo.svg" class="logo"></p>
			<form class="search" action="./">
				<input type="search" name="q" class="q" placeholder="Filtrar">
			</form>
		</header>
		<article class="initiative">
			<h1><a href="{{número}}.html">{{tipo}}</a></h1>
			<p>Iniciativa presentada por <span class="proponent">{{proponente}}</span> en <span class="year">{{año}}</span>.</p>
			{{#url}}
			<p class="status"><a href="{{url}}">{{trámite}}</a></p>
			{{/url}}
			{{^url}}
			<p class="status">{{trámite}}</p>
			{{/url}}
			{{{asunto}}}
		</article>
	</body>
</html>
