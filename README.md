# Drow Saga

Drow Saga fait du drow une race jouable dans **Baldur's Gate : Enhanced Edition** (avec **Siege of Dragonspear**) et **Baldur's Gate II : Enhanced Edition** (avec **Throne of Bhaal**), et réécrit une grande partie de l'aventure pour un héros ou une héroïne drow : de Château-Suif aux épilogues de ToB, le monde, les compagnons et leurs romances réagissent à qui vous êtes.

Le héros reste celui du jeu : un enfant recueilli par Gorion et élevé à Château-Suif. Il n'a jamais vécu dans l'Ombre-Terre, mais tout le monde à la surface ne voit d'abord en lui que la réputation de son peuple.

Le drow est une sous-race de l'elfe : choisissez Elfe à la création, puis « Choisir une sous-race » (interface du jeu de base) ou « Sous-races » (Infinity UI++). Le contenu est écrit en français ; la version anglaise viendra plus tard.

**Version actuelle : 1.0.1** — téléchargez le paquet dans les [versions publiées](https://github.com/Jeehan-Rendar/Drow-Saga/releases).

## Traits du drow

- +2 Dextérité, -1 Constitution, +1 Intelligence.
- 50 % de résistance à la magie. Infravision.
- +1 au TAC0 avec les arcs, épées longues et épées courtes.
- Ne reçoit que 90 % de l'expérience (affichage : 90 % de l'XP réelle, XP de départ comprise).
- Réputation initiale réduite de 2 (une seule fois par groupe et par campagne).
- Sensibilité à la lumière : dehors et de jour, +1 au TAC0 et +1 aux jets de sauvegarde. Au niveau 9, l'acclimatation à la surface supprime définitivement cette gêne.
- Viconia et Baeloth sont affichés « Drow » sur leur fiche (simple libellé : aucun trait ajouté, rien d'autre de changé pour eux).

## Les composants

| N° | Composant | Contenu |
|---|---|---|
| 0 | Noyau, le drow comme race jouable (obligatoire) | Les règles du drow, sans aucun dialogue. |
| 10 ou 20 | Interface (une au choix) | 10 : l'interface du jeu de base ; 20 : Infinity UI++, compatible avec sa dernière version, la 1.4 (Infinity UI++ doit être installé avant). |
| 30 | BG1 et SoD, le monde réagit au drow | Plus d'un millier de répliques réécrites ou ajoutées : gardes, marchands, prêtres, villageois et personnages de l'histoire remarquent le héros, s'en méfient ou s'en amusent, de Château-Suif à la Porte de Baldur, puis dans Siege of Dragonspear. Sur les routes, des embuscades attendent le drow : chasseurs de primes, Flèches Noires de Shevarash, foule en colère. Les compagnons du jeu réagissent eux aussi, et toutes les romances de SoD sont adaptées au héros drow. La lettre de Gorion et le journal racontent son enfance d'elfe noir élevé à Château-Suif. |
| 50 | BG1 et SoD avec BG1 NPC, compagnons et romances | Pour BG1 NPC Project : les compagnons du mod parlent au héros comme à un drow, et les romances de Branwen, Shar-Teel, Coran et Xan lui sont ouvertes. Exige le 30 et une version à jour de BG1 NPC Project, avec sa traduction française officielle (novembre 2026). |
| 60 | BG1 et SoD, corrections du texte français (facultatif, à installer en dernier) | Quelques centaines de fautes de la traduction d'origine, surtout dans le journal ; « surfacin » devient « surfacien » comme dans BG2. |
| 40 | Portrait de Viconia de Siege of Dragonspear (facultatif) | Le portrait de SoD pour Viconia dans BG1, BG2 et l'épilogue de ToB. |
| 200 | BG2 et ToB, le monde réagit au drow | Plus d'un millier de répliques, sur toute l'aventure : Irenicus et Imoen, Athkatla, les quêtes hors de la ville, l'Ombre-Terre, où le héros passe enfin pour l'un des siens, Suldanessellar, puis le Trône de Bhaal jusqu'aux épilogues. Les compagnons ont des échanges propres au héros drow, et toutes les romances de BG2EE sont adaptées à qui il est. Pris en charge : Ascension (versions de Gaider et de Shawne), dont les épilogues sont adaptés eux aussi. |
| 260 | BG2 et ToB, corrections du texte français (facultatif) | Un millier de fautes de la traduction d'origine (orthographe, accords, mots manquants, étiquettes restées dans le texte), pour tous les héros, drow ou non. |

Une partie avec un héros d'une autre race reste inchangée.

## Jeux et prérequis

- BGEE 2.6 ou plus avec Siege of Dragonspear : DLC Merger doit être installé **avant** Drow Saga.
- BG2EE 2.6 ou plus (Shadows of Amn et Throne of Bhaal).
- EET : non pris en charge.
- Testé sur la version 2.7.3 des jeux.

## Installation

1. Téléchargez le paquet de la dernière [version publiée](https://github.com/Jeehan-Rendar/Drow-Saga/releases) et décompressez-le dans le dossier du jeu (à côté de `chitin.key`).
2. Lancez `setup-drowsaga.exe` et choisissez la langue.
3. Installez les composants dans cet ordre :
   - **BG1 et SoD** : DLC Merger, Infinity UI++ 1.4 (si vous l'utilisez), BG1 NPC Project (si vous l'utilisez) et les autres mods, puis Drow Saga 0, 10 ou 20, 30, 50, 60 (40 si vous le voulez).
   - **BG2 et ToB** : Ascension et les autres mods, puis Drow Saga 0, 10 ou 20, 200, 260 (40 si vous le voulez).

Installez Drow Saga après les mods qui remplacent l'interface (`UI.menu`).

Pour désinstaller, relancez `setup-drowsaga.exe` et retirez les composants (l'interface, puis le noyau en dernier).

## Imports

Le drow garde ses traits de BGEE à SoD, puis à BG2 et à ToB, par sauvegarde, par fiche `.CHR` ou par l'import du menu. Au récapitulatif d'import, la race peut s'afficher « Elfe ou Drow » quand le jeu ne permet pas de savoir : c'est un simple libellé, le personnage retrouve ses traits et sa fiche « Drow » en jeu.

## Limites connues

- Ouvrir la fiche pendant le dialogue d'ouverture de BG2 montre les valeurs d'avant Drow Saga (les scripts du jeu sont suspendus) : attendez la fin du dialogue.
- Infinity UI++ : Drow Saga ramène à 4 le nombre d'emplacements de sauvegarde rapide (les emplacements 5 et 6 écrasent les sauvegardes de début de chapitre).

## Signaler un problème

Ouvrez un ticket dans les [Issues](https://github.com/Jeehan-Rendar/Drow-Saga/issues). Notez le jeu (BGEE, SoD, BG2 ou ToB), l'interface, ce que vous avez fait, ce que vous avez vu, et joignez une capture d'écran.

## Licence et crédits

- **Le code et les textes de Drow Saga** sont libres d'usage et d'adaptation, à condition de citer Drow Saga et son auteur (dans l'esprit de la licence [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.fr)).
- **Fichiers tiers**, qui restent la propriété de leurs auteurs et ne sont pas couverts par cette licence :
  - les fichiers d'interface du jeu de base (`drowsaga/ui/vanilla*/UI.menu`, adaptés) et les portraits de Viconia de Siege of Dragonspear (`drowsaga/portraits`) : Beamdog ;
  - le fichier d'interface d'Infinity UI++ (`drowsaga/ui/infinity_ui_14/UI.menu`, adapté) : Renegade0 sur GitHub, Pecca sur les forums de Beamdog.
- **Remerciements** : l'équipe de BG1 NPC Project, The Gibberlings Three, et les auteurs de WeiDU.
