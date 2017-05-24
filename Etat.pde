/**
 * État.
 */
class Etat {
  /**
   * Nom de l'état.
   */
  String nom;

  /**
   * Sprite de l'état.
   */
  Sprite sprite;

  /**
   * Acteur de l'état.
   */
  Acteur acteur;

  /**
   * Durée de l'état.
   */
  int duree;

  /**
   * Compteur de trames de l'état.
   */
  int compteurTrames;

  /**
   * Coordonnées du point d'ancrage de l'état.
   */
  float ax, ay;

  /**
   * Constructeur simple.
   * @param _nom Nom de l'état.
   * @param _spritesheet Spritesheet de l'état.
   */
  Etat(String _nom, String _spritesheet) {
    this(_nom, _spritesheet, 1, 1);
  }

  /**
   * Constructeur complet.
   * @param _nom Nom de l'état.
   * @param _spritesheet Spritesheet de l'état.
   * @param _lignes Nombre de lignes du spritesheet.
   * @param _colonnes Nombre de colonnes du spritesheet.
   */
  Etat(String _nom, String _spritesheet, int _lignes, int _colonnes) {
    /* Nom de l'état. */
    nom = _nom;
    
    /* Définition de la durée comme nulle. */
    duree = -1;
    
    /* Création de la sprite. */
    sprite = new Sprite(_spritesheet, _lignes, _colonnes);
    sprite.definirEtat(this);
  }

  /**
   * Ajouter un point de chemin.
   * @param _x Coordonnée x du point.
   * @param _y Coordonnée y du point.
   * @param _duree Durée de déplacement.
   */
  void ajouterPointChemin(float _x, float _y, int _duree) {
    sprite.ajouterPointChemin(_x, _y, 1, 1, 0, _duree);
  }

  /**
   * Ajouter un point de chemin.
   * @param _x Coordonnée x du point.
   * @param _y Coordonnée y du point.
   * @param _ex Echelle x de la sprite.
   * @param _ey Echelle y de la sprite.
   * @param _rotation Rotation de la sprite.
   * @param _duree Durée de déplacement.
   */
  void ajouterPointChemin(float _x, float _y, float _ex, float _ey, float _rotation, int _duree) {
    sprite.ajouterPointChemin(_x, _y, _ex, _ey, _rotation, _duree);
  }

  /**
   * Ajouter un chemin linéaire.
   * @param _x1 Coordonnée x de départ.
   * @param _y1 Coordonnée y de départ.
   * @param _x2 Coordonnée x d'arrivée.
   * @param _y2 Coordonnée y d'arrivée.
   * @param _duree Durée de déplacement.
   */
  void ajouterChemin(float _x1, float _y1, float _x2, float _y2, float _duree) {
    sprite.ajouterChemin(_x1, _y1, 1, 1, 0, _x2, _y2, 1, 1, 0, _duree);
  }

  /**
   * Ajouter un chemin linéaire.
   * @param _x1 Coordonnée x de départ.
   * @param _y1 Coordonnée y de départ.
   * @param _ex1 Echelle x de départ de la sprite.
   * @param _ey1 Echelle y de départ de la sprite.
   * @param _rotation1 Rotation de départ de la sprite.
   * 
   * @param _x2 Coordonnée x d'arrivée.
   * @param _y2 Coordonnée y d'arrivée.
   * @param _ex2 Echelle x d'arrivée de la sprite.
   * @param _ey2 Echelle y d'arrivée de la sprite.
   * @param _rotation2 Rotation d'arrivée de la sprite.
   * 
   * @param _duree Durée de déplacement.
   */
  void ajouterChemin(float _x1, float _y1, float _ex1, float _ey1, float _rotation1,
                     float _x2, float _y2, float _ex2, float _ey2, float _rotation2,
                     float _duree) {
    sprite.ajouterChemin(_x1, _y1, _ex1, _ey1, _rotation1, _x2, _y2, _ex2, _ey2, _rotation2, _duree);
  }

  /**
   * Définir le chemin comme étant une boucle.
   * @param _boucle Le chemin doit-il être répété ?
   */
  void definirBoucle(boolean _boucle) {
    sprite.definirBoucle(_boucle);
  }

  /**
   * Définir la durée de l'état.
   * @param _duree Durée de l'état.
   */
  void definirDuree(float _duree) {
    definirBoucle(false);
    duree = int(_duree);
  }

  /**
   * Définir l'acteur de cet état.
   * @param _acteur Acteur de l'état.
   */
  void definirActeur(Acteur _acteur) {
    acteur = _acteur;
    acteur.largeur = sprite.largeur;
    acteur.hauteur = sprite.hauteur;
  }

  /**
   * Définir le décalage de l'acteur.
   * @param _mx Décalage x de l'acteur.
   * @param _my Décalage y de l'acteur.
   */
  void definirDecalageActeur(float _mx, float _my) {
    acteur.definirDecalage(_mx, _my);
  }

  /**
   * Définir les dimensions de l'acteur.
   * @param _largeur Largeur de l'acteur.
   * @param _hauteur Hauteur de l'acteur.
   * @param _alignementH Alignement horizontal de l'acteur.
   * @param _alignementV Aligmenent vertical de l'acteur.
   */
  void definirDimensionsActeur(float _largeur, float _hauteur, float _alignementH, float _alignementV) {
    acteur.largeur = _largeur;
    acteur.hauteur = _hauteur;
    acteur.alignementH = _alignementH;
    acteur.alignementV = _alignementV;
  }

  /**
   * Définir la vitesse d'animation de l'état.
   * @param _facteur Facteur de vitesse.
   */
  void definirVitesseAnimation(float _facteur) {
    /* Définir la vitesse d'animation de la sprite. */
    sprite.definirVitesseAnimation(_facteur);
  }

  /**
   * Réinitiliser l'état.
   */
  void reinitialiser() {
    /* Réinitialiser la sprite. */
    sprite.reinitialiser();

    /* Remise à zéro du compteur. */
    compteurTrames = 0;
  }

  /**
   * Lorsque l'état est fini.
   */
  void fini() {
    /* Si l'acteur existe. */
    if(acteur != null) {
      /* On prévient l'acteur que l'état est fini. */
      acteur.EvenementEtatFini(this);
    }
  }

  /**
   * Vérifier si l'état est fini.
   */
  boolean peutChanger() {
    /* Si l'état a une durée. */
    if (duree != -1) {
      return false;
    }
    
    /* Vérifier si la sprite est finie. */
    return sprite.peutChanger(); 
  }

  /**
   * Vérifier qu'une position est sur la sprite.
   * @param _x Coordonnée x à vérifier.
   * @param _y Coordonnée y à vérifier.
   */
  boolean verifierPosition(float _x, float _y) {
    return sprite.verifierPosition(_x, _y);
  }

  /**
   * Affichage de l'état.
   */
  void draw(boolean _desactiver) {
    /* Si l'état est désactivé. */
    if(_desactiver && frameCount % 2 == 0) {
      /* On affiche une trame sur deux. */
    } else {
      /* Sinon, on affiche toutes les trames. */
      sprite.draw(0,0);
    }
    compteurTrames++;

    /* Si le compteur a atteint la durée de l'état. */
    if(compteurTrames == duree) {
      /* L'état est fini. */
      fini();
    }
  }

  /**
   * Récupérer les informations de déboguage.
   */
  String deboguer() {
    return "Etat: Nom:" + nom + ", durée:" + duree;
  }
}