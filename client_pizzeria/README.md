# client_pizzeria

Se us proporciona una app que s'està desenvolupant per a una pizzeria, la qual, tot i ser funcional, requereix d'algunes millores.

El funcionament desitjat és el que es mostra al vídeo.

## Estructura de l'aplicació

L'aplicació segueix una arquitectura basada en CLEAN, molt semblant a la utilitzada a l'APP de Comarques:

```
lib
├── domain
│   ├── entities        // Entitats del domini: Pizza
│   │   └── pizza.dart    
│   └── repository      // Repositoris abstractes
│       └── pizza_repository.dart
├── infrastructure
│   ├── data_sources    // Fonts de dades
│   │   └── pizza_api.dart
│   ├── mappers         // Mapejadors
│   │   └── pizza_mapper.dart
│   └── repository      //  Implementacions concretes del repositori
│       └── pizza_repository_impl.dart
├── main.dart
├── repo_singleton.dart   //  Classe Singleton per accedir al reposotiri
├── repository
└── screens               // Capa de presentació
    ├── pizza_screen.dart       // Pantalla principal
    └── widgets                 // Widgets de suport
        ├── llista_pizzes.dart  // Llista de pizzes
        ├── pizza_detail.dart   // Detall de les pizzes
        └── pizza_item.dart     // Element de la llista de les pizzes
```

### Detall de l'API

El codi font de l'API REST es troba documentat [a Github](https://github.com/joamuran/pizza-rest-server). La URL a la que ens connectem per obtenir la informació és `https://pizza-rest-server-production.up.railway.app/api/pizzeria/pizzes`.

La capa d'infraestructura  ja ofereix una implementació per realitzar peticions *GET* a aquesta URL, pel que en principi no huariem de modificar gran cosa en aquesta classe. De tota manera, després aprofundirem en els paràmetres que rep aquest servei.

## Millores a implementar

Se'ns demanen les següents funcionalitats:

### Millora 1. Interacció amb la llista de pizzes

Es desitja que quan l'usuari toque sobre algun item de la llista de pizzes, es mostre a la vista superior un text amb els ingredients de la pizza seleccionada i la seua imatge en gran.

Segurament, necessiteu algun mecanisme per saber quina és la pizza que s'està mostrant actualment. Per a això caldrà que feu ús de widgets amb estat que recorden quina és la pizza seleccionada i actualitzen la interfície.

 
### Millora 2. Paginació

El resultat que obtenim de l'API es presenta ja de forma paginada, i ens retorna els atributs `page`, `per_page` i `total_count` amb la pàgina actual de resultats, els resultats per pàgina i el nombre total de resultats que es mostren. A més, dins la propietat `records` és on tenim la llista de resultats.
  
De l'accés paginat a aquest contingut ja s'encarrega la capa d'infrastructura. Però observeu que li proporionem dos arguments:

* `pageNumber`, amb el número de pàgina, i
* `pageSize`, amb els resultats que volem per pàgina.

La invocació que es fa per defecte és amb `pageNumber:0` i `pageSize:6`, per a que ens mostre la primera pàgina i 6 resultats per pàgina. **Podeu modificar aquest comportament proporcionant-li arguments al mètode `getPizzes` del repositori.**

Podeu vore el resultat al navegador amb l'URL: `https://pizza-rest-server-production.up.railway.app/api/pizzeria/pizzes?pageNumber=0&pageSize=6`


### Millora 3. Afegir una llista d'alèrgens

Observeu que ara se'ns mostra un text indicant que *No s'han descrit alergens* en cada pizza.

Si observeu el contingut de la crida a l'API, veureu que ens retorna un paràmetre amb els alergens. Aquest paràmetre, de moment no s'ha tingut en compte en l'aplicació, però es desitja incorporar. Per a això, huareu de:

* Incorporar aquesta informació a l'entitat de domini corresponent
* Modificar el mapat de la informació que rebem de l'API per afegir aquesta informació a l'entitat de domini
* Crear un widget personalitzat amb les icones corresponents a la llista d'alergens.
* Reemplaçar el text dels alèrgens pel widget personalitzat.

> 
> **Consideracions**
>
> Aquest nou widget `LlistaAlergens`, es renderitzarà com un `Row` amb diferents `SizedBox` (d'un tamany de 32x32), i que continguen una imatge per cadascun dels alergens. 
> * Observeu que la llista d'alergens és una llista d'strings que s'emmagatzemarà a la classe `Pizza`, pel que tindrem accés directe a aquesta.
> * Les imatges les teniu ja disponibles a la carpeta `assets/img`. El nom d'aquestes imatges es correspon al nom de l'alergen amb extensió `".png"`, de manera que podeu construir-lo directament.
> * El que caldrà fer és registrar el contingut d'aquesta carpeta d'assets al fitxer de definició del projecte.
> 

### Millora 4. Interfície responsiva

En aquests moments, la interfície es mostra amb un disseny pla, i de fet, quan es gira la pantalla del dispositiu provoca un desbordament.

Es demana resoldre-ho, i fer aquesta interfície responsiva, de manera que adaptem el disseny a una vista en vertical o en horitzontal.


!!!warning "Compte!"
  No es poden utilitzar llibreries addicionals a les ja instal·lades al projecte!

## Rúbrica d'avaluació

A continuació es mostra la rúbrica d'avaluació, amb els diferents ítems i l'escala, en nivells per a la seua correcció.

### Millora 1. Interacció amb la llista de pizzes

* La pantalla *PizzaScreen* s'implementa com un widget amb estat, amb la llista de pizzes com a variable d'estat (0/1)
* S'ha afegit a l'estat la pizza actual (0/1)
* Quan es fa tap sobre un element de la llista s'actualitza la vista superior amb la informació. (0/1/2)
 
### Millora 2. Paginació

* S'afigen les propietats necessàries a l'estat per mantenir la paginació. (0/1)
* S'usa correctament el mètode `getPizzes` per obtenir els resultats paginats. (0/1)
* S'implementa la funcionalitat d'anar enrere en la paginació, tenint en compte que l'índex no siga inferior a 1. (0/1/2)
* S'implementa correctament la funcionalitat pe anar avant en la paginació. Es valorarà que es tinga en compte que no es retornen resultats (no apareixen pàgines en blanc) (0/1/3)

### Millora 3. Afegir una llista d'alèrgens

* Es modifiquen correctament les entitats de domini (0/1)
* Es modifiquen correctament els mappers  (0/1/2)
* Es registren correctament les imatges al fitxer del projecte (0/1)
* Es construeix correctament i seguint les especificacions el widget d'alergens (0/1/2/3)

### Millora 4. Interfície responsiva

* Es detecta correctament l'orientació de la pantalla (0/1/2)
* La pantalla s'ajusta correctament a l'orientació, mostrant els components apilats o un al costat de l'altre. (0/1/2)
* Es corregeix l'overflow de la part dels detalls de la pizza. (0/1/2)
