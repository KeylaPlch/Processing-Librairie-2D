/**
 * Une classe qui implémente cette interface sera capable de
 * s'afficher elle-même seulement si elle est visible dans la
 * boîte d'affichage actuelle.
 */
interface Affichable {
  /**
   * Affichage de l'objet.
   * @param _x Coordonné x du cadre d'affichage.
   * @param _y Coordonné y du cadre d'affichage.
   * @param _largeur Largeur du cadre d'affichage.
   * @param _hauteur Hauteur du cadre d'affichage.
   */
  void draw(float _x, float _y, float _largeur, float _hauteur);
}
