# Gestionnaire de mot de passe
Dart/Flutter 

## Table des matières

***

* [Installer le projet](#installer-le-projet)
  * [Cloner le projet](#cloner-le-projet)
  * [les dépendances](#mettre-à-jourinstaller-les-packages)
  * [Lancer le projet](#run-le-projet)
* [Compilation vers une plateforme cible](#compiler-le-projet-vers-windows)
* [Lancer les tests](#lancer-les-tests)
* [Cahier des charges](#cahier-des-charges)
* [Ressources](#ressources)
* [Commentaires](#difficultéscommentaires)

## Installer le projet
***

### Cloner le projet

via SSH :

```shell
git clone git@github.com:prevostclementDev/passwordManager.git
```

via HTTPS : 

````shell
git clone https://github.com/prevostclementDev/passwordManager.git
````

### Mettre à jour/installer les packages

````shell
flutter pub get
````

### Run le projet

````shell
flutter run lib/main.dart
````

## Compiler le projet vers windows
***

Si besoin, activer le support pour le build vers Windows.

```shell
flutter config --enable-windows-desktop
```

Compilation vers Windows :

````shell
flutter build windows
````

Le résultat du build est trouvable dans build\windows\x64\runner\Release

## Lancer les tests
***

Pour lancer les tests de la méthode Crypt :
<br>
(Test présent dans ./test/src/cryptographie/crypt_test.dart)
````shell
flutter test
````

## Cahier des charges
***

Le cahier des charges est présent à la racine du Repository Github : cahier_des_charges.pdf

## Ressources
***

Nous avons beaucoup utilisé la documentation officielle de Dart et de Flutter. Mais aussi dans certains cas les documentations des librairies (pour le cryptage notamment).
Ainsi que des forums (Stack Overflow) pour débug certaines situations.

Pour les tests unitaires :
https://invertase.io/blog/assertions-in-dart-and-flutter-tests-an-ultimate-cheat-sheet/   

- https://pub.dev/
- https://stackoverflow.com/
- https://docs.flutter.dev/

## Difficultés/Commentaires
***

C'est assez compliqué de se plonger dans un nouveau langage de style. On a l'habitude du HTML/CSS et ça change totalement, il faut s'habituer à nouveau. Ensuite, pour crypter les données, cela demande beaucoup de recherche, mais ça reste plus logique par rapport à nos habitudes du web. Selon nous, la plus grande difficulté, c'est de devoir s'adapter du web au desktop.
