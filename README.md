# AdaptiSound
Complete BGM Manager for Godot 4.0

AdaptiSound te ayudará a implementar la música en tu videojuego. Explora el mundo de la música interactiva y adaptativa con las diferentes herramientas que te entrega este plugin.
Tu creatividad es el límite!


## 🎵 AdaptiSound v0.1 ![](https://camo.githubusercontent.com/d8177663f486ebdd812419dbf9fe4f8e750c01f2026590e5994ee31bbf7a8123/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f476f646f742d76342e302d253233343738636266)
### ⚙ Installation
To Install AdaptiSound you must download the ZIP file, once downloaded move the `/addons` in the root of your project. Once the project is open you must activate the plugin in the project settings. If you see errors in the output panel, you might need to reboot the editor after enabling AdaptiSound for the first time.

If you want to know more about installing plugins you can read the [Godot docs page](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html)


## 🎛Documentation
### Main Panel
El `Main Panel` te ayudará a organizar los archivos de audio en tu proyecto.
El objetivo es separar la música en 3 categorías diferentes:
- `BGM` (Background Music)
- `BGS` (Background Sounds)
- `ABGM` (Adaptive Background Music)
Deberás asignar un directorio para cada categoría, el singleton `AudioManager` se encargará de cargar los archivos para su posterior uso en el juego.
En `Main Panel` podrás visualizar el contenido de los directorios, elegir un bus de audio diferente para cada categoría, y elegir la extension de los archivos que deseas cargar.


### AudioManager Singleton
- AdaptiveTrack Node
- ParallelTrack Node


### Made by 
Isaías Arrué R. `(Mr. Walkman)`

[MIT License](https://github.com/MrWalkmanDev/AdaptiSound/blob/main/LICENSE)
