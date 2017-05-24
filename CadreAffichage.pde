/**
 * Cadre d'affichage.
 */
class CadreAffichage {
  /**
   * Coordonnées du cadre d'affichage.
   */
  float x, y;

  /**
   * Taille du cadre d'affichage.
   */
  float largeur, hauteur;

  /**
   * Coordonnées de la couche de niveau du cadre.
   */
  float couche_x, couche_y;

  /**
   * Echelle de la couche de niveau du cadre.
   */
  float couche_echelleX = 1, couche_echelleY = 1;

  /**
   * Constructeur.
   */
  CadreAffichage() {}

  /**
   * Constructeur simple.
   * @param _largeur Largeur du cadre d'affichage.
   * @param _hauteur Hauteur du cadre d'affichage.
   */
  CadreAffichage(float _largeur, float _hauteur) { 
    /* Définition de la taille du cadre. */
    largeur = _largeur;
    hauteur = _hauteur;
  }
  
  /**
   * Constructeur complet.
   * @param _x Coordonnée x du cadre d'affichage.
   * @param _y Coordonnée y du cadre d'affichage.
   * @param _largeur Largeur du cadre d'affichage.
   * @param _hauteur Hauteur du cadre d'affichage.
   */
  CadreAffichage(float _x, float _y, float _largeur, float _hauteur) {
    /* Définition de la position du cadre. */
    x = _x;
    y = _y;

    /* Définition de la taille du cadre. */
    largeur = _largeur;
    hauteur = _hauteur;
  }

  /**
   * Récupérer la coordonnée x du cadre d'affichage.
   * @return Coordonnée x du cadre d'affichage.
   */
  float recupererX() {
    return x - couche_x;
  }

  /**
   * Récupérer la coordonnée y du cadre d'affichage.
   * @return Coordonnée y du cadre d'affichage.
   */
  float recupererY() {
    return y - couche_y;
  }

  /**
   * Récupérer la largeur du cadre d'affichage.
   * @return Largeur du cadre d'affichage.
   */
  float recupererLargeur()  {
    return largeur * couche_echelleX;
  }

  /**
   * Récupérer la hauteur du cadre d'affichage.
   * @return Hauteur du cadre d'affichage.
   */
  float recupererHauteur() {
    return hauteur *couche_echelleY;
  }

  /**
   * Définir la couche de niveau à afficher.
   * @param _couche Couche de niveau à afficher.
   */
  void definirCoucheNiveau(CoucheNiveau _couche) {
    /* Si la couche n'est pas standard. */
    if (_couche.nonstandard) {
      couche_x = _couche.translationX;
      couche_y = _couche.translationY;
      couche_echelleX = _couche.echelleX;
      couche_echelleY = _couche.echelleY;
    }
  }

  /**
   * Repositionner le cadre en fonction de la position de l'acteur.
   * @param _niveau Niveau de l'acteur à suivre.
   * @param _acteur Acteur à suivre.
   */
  void traquer(Niveau _niveau, Acteur _acteur) {
    /* Définition de la couche de niveau du cadre. */
    definirCoucheNiveau(_acteur.recupererCoucheNiveau());

    /* Récupération des coordonnées de l'acteur. */
    float ax = round(_acteur.recupererX());
    float ay = round(_acteur.recupererY());

    /* Idéalement l'acteur est au centre du cadre. */
    float idealx = ax - largeur/2;
    float idealy = ay - hauteur/2;

    /* Définition de la position du cadre. */
    x = min(max(0, idealx), _niveau.largeur - largeur);
    y = min(max(0, idealy), _niveau.hauteur - hauteur);
  }

  /**
   * Récupérer les informations de déboguage.
   */
  String deboguer() {
    return x + "/" + y + " - " + largeur + "/" + hauteur;
  }
}