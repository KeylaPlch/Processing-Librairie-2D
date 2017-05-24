/**
 * Une classe qui implémente cette interface sera capable de
 * s'afficher elle-même seulement si elle est visible dans la
 * boîte d'affichage actuelle.
 */
interface Affichable {
  /**
   * Affichage de l'objet.
   * @param _x1 Coordonné x1 du cadre d'affichage.
   * @param _y1 Coordonné y1 du cadre d'affichage.
   * @param _x2 Coordonné x2 du cadre d'affichage.
   * @param _y2 Coordonné y2 du cadre d'affichage.
   */
  void draw(float _x1, float _y1, float _x2, float _y2);
}