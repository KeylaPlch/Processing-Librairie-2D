/**
 * Objet.
 */
class Objet extends Acteur {
  /**
   * Nom de la sprite de l'objet.
   */
  String spritesheet;
  
  /**
   * Nombre de lignes de la sprite.
   */
  int lignes;
  
  /**
   * Nombre de colonnes de la sprite.
   */
  int colonnes;

  /**
   * Constructeur d'objet.
   * @param _nom Nom de l'objet.
   * @param _spritesheet Spritesheet de l'objet.
   * @param _lignes Lignes de sprites dans le spritesheet.
   * @param _colonnes Colonnes de sprites dans le spritesheet.
   * @param _x Coordonnée x de l'objet.
   * @param _y Coordonnée y de l'objet.
   */
  Objet(String _nom, String _spritesheet, int _lignes, int _colonnes, float _x, float _y) {
    super(_nom);
    
    /* Définition de la sprite de l'objet. */
    spritesheet = _spritesheet;
    lignes = _lignes;
    colonnes = _colonnes;

    definirEtats();
    definirPosition(_x, _y);
    alignerSprite(CENTRE, CENTRE);
  }

  /**
   * Définition des états de l'objet.
   */
  void definirEtats() {
    Etat objet = new Etat(nom, spritesheet, lignes, colonnes);
    objet.sprite.definirVitesseAnimation(0.25);
    ajouterEtat(objet);
  }
  
  /**
   * Aligner la sprite de l'objet.
   * @param _alignementH Alignement horizontal.
   * @param _alignementV Alignement vertical.
   */
  void alignerSprite(int _alignementH, int _alignementV) {
    actif.sprite.aligner(_alignementH, _alignementV);
  }

  /**
   * Déterminer si l'objet est visible dans le cadre d'affichage actuel.
   */
  boolean affichable(float _x1, float _y1, float _x2, float _y2) {
    boolean affichable = (_x1 - _x2 <= x && x <= _x1 + 2 * _x2 &&  _y1 - _y2 <= y && y <=  _y1 + 2 * _y2);
    
    /* Si l'objet n'est pas affichage. */
    if(!affichable) { supprimerActeur(); }

    return affichable;
  }

  //--------------------------//
  //        EVENEMENTS.       //
  //--------------------------//
  
  /**
   * Événement de ramassage d'un objet.
   * @param _acteur Acteur ayant ramassé l'objet.
   */
  void EvenementRamasser(Acteur _acteur) {} 

  /**
   * Événement de ramassage d'un objet.
   * @param _objet Objet ramassé.
   */
  final void EvenementRamasser(Objet _objet) {}

  /**
   * Événement de controles.
   */
  final void EvenementControles() {}

  /**
   * Événement de fin d'état.
   * @param _etat État ayant fini son animation.
   */
  final void EvenementEtatFini(Etat _etat) {}

  /**
   * Événement de collision.
   * @param _acteur Acteur de la collision.
   */
  void EvenementCollision(Acteur _acteur) {
    supprimerActeur();
    _acteur.EvenementRamasser(this);
    EvenementRamasser(_acteur);
  }
}