# Slime Survivor 🟢⚔️

Witamy w repozytorium **Slime Survivor**! To gra akcji 2D zręcznościowa typu "survivor" stworzona w silniku **Godot 4**. Twoim zadaniem jest przetrwanie hord nacierających slime'ów w zróżnicowanych środowiskach, zbieranie monet od pokonanych wrogów i ukończenie wszystkich stref.

Gra charakteryzuje się proceduralnie generowanym środowiskiem (drzewa, lawa) oraz dynamicznie narastającym tempem rozgrywki.

---

## 🎮 O grze

Rozgrywka polega na przetrwaniu na mapie przez określony czas, jednoczesnym unikaniu przeciwników oraz zbieraniu monet, które "wypadają" ze zniszczonych, większych wrogów (tzw. Mega Mobów). Twój bohater strzela automatycznie do najbliższych celów - Twoim głównym zadaniem jest zręczne poruszanie się po arenie oraz zebranie monet aby przejść do następnego poziomu.

### Kluczowe elementy:
* **Odliczanie czasu:** Każdy poziom wymaga przetrwania do momentu wygaśnięcia czasu na liczniku (np. 2, 3 lub 4 minuty, w zależności od etapu). Jeśli w tym czasie nie zbierzesz wymaganej ilości monet, by przejść dalej, gra zostanie przerwana.
* **Auto-aim i ruch:** Broń steruje się sama. Ty skupiasz się na tym, gdzie iść.
* **Środowisko to Twój wróg:** Na mapach generują się przeszkody. Niektóre po prostu blokują ruch, inne, jak rozgrzana lawa, natychmiastowo Cię zniszczą.

---

## 🗺️ Poziomy (Strefy)

Zabawa podzielona jest na trzy odrębne strefy:

1. **Strefa 1**
   * **Cel:** 5 monet.
   * **Czas:** 2 minuty.
   * **Opis:** Wprowadzenie do gry. Gęsty las (proceduralnie generowane drzewa) o przyjemnym dla oka, jasnozielonym kolorze tła. Przeciwnicy poruszają się w standardowym tempie. Ewentualna porażka oznacza "zginąłeś: Tym razem slime'y wygrały...".

2. **Strefa 2: Kraina Mrozu**
   * **Cel:** 5 monet.
   * **Czas:** 3 minuty.
   * **Opis:** Akcja przenosi się w chłodniejszy, błękitny krajobraz zimowy. Generowanych jest więcej drzew, a slime'y przyspieszają (wskutek "ślizgania się na lodzie"). Jeśli zawiedziesz, znowu "zginąłeś". 

3. **Strefa 3: Gniazdo Bossa**
   * **Cel:** 10 monet.
   * **Czas:** 4 minuty.
   * **Opis:** Ostatnie, ekstremalne wyzwanie. Mroczna, czerwonawa kraina usiana lawą (dotknięcie jej to natychmiastowy "game over"). Przeciwnicy są jeszcze szybsi, a do tego musisz zmierzyć się z bossem.
   * **Zwycięstwo:** Po zebraniu 10 monet stajesz się Prawdziwym Bohaterem! Ekran końcowy nagrodzi Cię podsumowaniem: "BOSS POKONANY!".

---

## 🕹️ Sterowanie

* **Klawisze W, A, S, D** - Poruszanie się postacią we wszystkich kierunkach.
* Strzelanie odbywa się automatycznie w stronę wrogów.

---

## 🛠️ Struktura Projektu i Technologie

Projekt działa w oparciu o silnik **Godot 4.x** (Forward+ Renderer) oraz język GDScript. Do stworzenia gry wykorzystano m.in.:

* Ekrany UI (`CanvasLayer`, `ColorRect`, z niestandardową czcionką `Squidgy Slimes.ttf` dla klimatu).
* Proceduralne generowanie węzłów (odpowiedzialne za to są skrypty w poszczególnych poziomach, wywołujące na start mapy funkcję układającą drzewa i lawę w zdefiniowanych granicach pola `SPAWN_AREA`).
* Autoload/Singletony (np. `global_music.gd` zapewniające ciągłość oprawy dźwiękowej w przejściach ekranów).
* Grupy i Sygnały do komunikacji, m.in. dla detekcji obrażeń i wpadnięcia do lawy (grupa `player`).

### Ważniejsze pliki:
* `project.godot` - Główne konfiguracje gry (uruchamia aplikację w klasycznym oknie).
* `menu.tscn` - Ekran początkowy, z tłem `MainMenuBackground.png`.
* `levels/slime_survivor_l1-3` - Pliki ze skryptami i strukturą poziomów.
* `objects/lava.tscn` / `.gd` - Area2D zabijająca postać w Strefie 3.

---

## 🚀 Instalacja i Uruchomienie

1. Zainstaluj **Godot Engine 4** (dostępny za darmo na oficjalnej stronie).
2. Pobierz te pliki na dysk komputera.
3. Uruchom Godot, wybierz "Importuj" w menedżerze projektów i wskaż plik `project.godot` z rozpakowanego folderu.
4. Kliknij dwukrotnie projekt i naciśnij `F5`, aby wypróbować gotową grę na własnej skórze.
