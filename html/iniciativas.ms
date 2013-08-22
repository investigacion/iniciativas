<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="utf-8">
		<title>Iniciativas — La Nación</title>
		<link rel="stylesheet" href="../css/iniciativas.css">
	</head>
	<body>
		<header class="app">
			<h1>Iniciativas</h1>
			<p><img alt="La Nación" src="../img/nacion-logo.svg" class="logo"></p>
			<form class="search">
				<input type="search" name="q">
			</form>
		</header>
		<nav class="index">
			<ul>
				{{#initiatives}}
				<li>
					<a href="iniciativas/{{número}}" title="{{tipo}} — {{proponente}}"><h2>{{tipo}}</h2></a>
					<p>Iniciativa presentado por {{proponente}} en {{año}}.</p>
				</li>
				{{/initiatives}}
			</ul>
		</nav>
	</body>
</html>
