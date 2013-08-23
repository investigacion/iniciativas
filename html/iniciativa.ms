<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="utf-8">
		<title>Iniciativas — La Nación</title>
		<link rel="stylesheet" href="css/iniciativa.css">
	</head>
	<body>
		<header class="app">
			<h1><a href="./">Iniciativas</a></h1>
			<p><img alt="La Nación" src="img/nacion-logo.svg" class="logo"></p>
			<form class="search">
				<input type="search" name="q" class="q" placeholder="Filtrar">
			</form>
		</header>
		<article class="initiative">
			<h1><a href="{{número}}.html">{{tipo}}</a></h1>
			<p>Iniciativa presentado por {{proponente}} en {{año}}.</p>
			<p>{{asunto}}</p>
		</article>
	</body>
</html>
