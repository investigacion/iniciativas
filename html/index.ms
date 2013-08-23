<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="utf-8">
		<title>Iniciativas — La Nación</title>
		<link rel="stylesheet" href="css/index.css">
		<script src="js/index.js" async></script>
	</head>
	<body>
		<header class="app">
			<h1>Iniciativas</h1>
			<p><img alt="La Nación" src="img/nacion-logo.svg" class="logo"></p>
			<form class="search">
				<input type="search" name="q" class="q" placeholder="Filtrar">
				<p class="total">{{initiatives.length}} iniciativas</p>
			</form>
		</header>
		<nav class="index">
			<ul>
				{{#initiatives}}
				<li data-id="{{número}}">
					<h2><a href="{{número}}.html">{{tipo}}</a></h2>
					<p>Iniciativa presentado por {{proponente}} en {{año}}.</p>
				</li>
				{{/initiatives}}
			</ul>
		</nav>
	</body>
</html>
