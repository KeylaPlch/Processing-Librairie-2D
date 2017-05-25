/**
 * Les déclencheurs définissent une région que le joueur
 * doit traverser pour actionner une fonction.
 */
abstract class Declencheur extends Positionnable {
  /**
   * Nom du déclencheur.
   */
  String nom;
  
  /**
   * Le déclencheur doit-il être désactivé ?
   */
  boolean desactiver;
  
  /**
   * Le déclencheur doit-il être supprimé ?
   */
  boolean supprimer;

  /**
   * Constructeur simple.
   * @param _nom Nom du déclencheur.
   */
  Declencheur(String _nom) {
    nom = _nom;  
  }

  /**
   * Constructeur complet.
   * @param _nom Nom du déclencheur.
   * @param _x Coordonnée x du déclencheur.
   * @param _y Coordonnée y du déclencheur.
   * @param _largeur Largeur du déclencheur.
   * @param _hauteur Hauteur du déclencheur.
   */
  Declencheur(String _nom, float _x, float _y, float _largeur, float _hauteur) {
    super(_x, _y, _largeur, _hauteur);
    nom = _nom;
  }
  
  /**
   * Définir région de déclenchement.
   * @param _x Coordonnée x du déclencheur.
   * @param _y Coordonnée y du déclencheur.
   * @param _largeur Largeur du déclencheur.
   * @param _hauteur Hauteur du déclencheur.
   */
  void definirRegion(float _x, float _y, float _largeur, float _hauteur) {
    definirPosition(_x, _y);
    largeur = _largeur;
    hauteur = _hauteur;
  }
 
  /**
   * Activer le déclencheur.
   */
  void activer() {
    desactiver = false;
  }

  /**
   * Désactiver le déclencheur.
   */
  void desactiver() {
    desactiver = true;
  }
  
  /**
   * Supprimer le déclencheur.
   */
  void supprimerDeclencheur() {
    supprimer = true;
  }

  /**
   * Déterminer si l'objet est visible dans le cadre d'affichage actuel.
   */
  boolean affichable(float _x, float _y, float _largeur, float _hauteur) {
    return _x <= x + largeur && x <= _x + _largeur && _y <= y + hauteur && y <= _y + _hauteur;
  }
  
  /**
   * Afficher le déclencheur.
   */
  void afficherObjet() {
    stroke(255,127,0,150);
    fill(255,127,0,150);
    rect(-width/2,height/2,width,height);
    fill(0);
    textSize(12);
    float tw = textWidth(nom);
    text(nom,-5-tw,height);
  }

  //--------------------------//
  //        EVENEMENTS.       //
  //--------------------------//
  
  /**
   * Événement de déclenchement.
   * @param _couche Couche de niveau du déclenchement.
   * @param _acteur Acteur ayant traversé la zone de déclenchement.
   * @param _intersection Tableau d'informations de collision.
   */
  abstract void EvenementDeclencher(CoucheNiveau _couche, Acteur _acteur, float[] _intersection);
}
