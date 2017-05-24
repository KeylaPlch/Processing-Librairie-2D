/**
 * Dans les jeux en deux dimensions, tout à lieu dans des
 * écrans. Certains écrans sont des menus et d'autres des
 * niveaux.
 */
abstract class Ecran {
  /**
   * Dimensions de l'écran.
   */
  float largeur, hauteur;

  /**
   * L'écran est-il remplaçable ?
   */
  boolean remplacable;

  /**
   * Constructeur simple.
   * @param _largeur Largeur de l'écran.
   * @param _hauteur Hauteur de l'écran.
   */
  Ecran(float _largeur, float _hauteur) {
    largeur = _largeur;
    hauteur = _hauteur;
  }
  
  /**
   * Définir l'écran comme remplaçable.
   */
  void definirRemplacable() {
    remplacable = true; 
  }
 
  /**
   * Affichage de l'écran.
   */ 
  abstract void draw();
  
  /**
   * Nettoyage de l'écran lorsque celui-ci est remplacé.
   */
  abstract void nettoyer();

  //--------------------------//
  //        EVENEMENTS.       //
  //--------------------------//
  
  abstract void keyPressed(char _touche, int _codeTouche);
  abstract void keyReleased(char _touche, int _codeTouche);
  abstract void mouseMoved(int _mouseX, int _mouseY);
  abstract void mousePressed(int _mouseX, int _mouseY, int _bouton);
  abstract void mouseDragged(int _mouseX, int _mouseY, int _bouton);
  abstract void mouseReleased(int _mouseX, int _mouseY, int _bouton);
  abstract void mouseClicked(int _mouseX, int _mouseY, int _bouton);
}