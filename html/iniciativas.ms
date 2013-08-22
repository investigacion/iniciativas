<!DOCTYPE html>
<html lang="es">
	<head>
		<link rel="stylesheet" href="css/iniciativas.css">
	</head>
	<body>
		<header class="app-header">
			<h1>Iniciativas</h1>
			<p><img alt="La Nación" src="img/nacion-logo.svg"></p>
			<form>
				<input type="search" name="q">
			</form>
		</header>
		<nav>
			<ul>
				{{#initiatives}}
				<li>
					<a href="iniciativas/{{número}}" title="{{tipo}} — {{proponente}}">
						<h2>{{tipo}}</h2>
						<p>Iniciativa presentado por {{proponente}} en {{año}}.</p>
					</a>
				</li>
				{{/initiatives}}
			</ul>
		</nav>
	</body>
</html>
