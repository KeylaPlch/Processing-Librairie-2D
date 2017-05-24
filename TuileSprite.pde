/**
 * Tuile de sprite.
 */
class TuileSprite extends Positionnable {
  /**
   * Sprite.
   */
  Sprite sprite;

  /**
   * Coordonnées de la sprite.
   */
  float x1, y1, x2, y2;

  /**
   * Constructeur complet.
   * @param _sprite Sprite de la tuile.
   * @param _x1 Coordonnée x1 de la sprite.
   * @param _x1 Coordonnée y1 de la sprite.
   * @param _x1 Coordonnée x2 de la sprite.
   * @param _x1 Coordonnée y2 de la sprite.
   */
  TuileSprite(Sprite _sprite, float _x1, float _y1, float _x2, float _y2) {
    /* Définition des coordonnées. */
    x1 = _x1;
    y1 = _y1;
    x2 = _x2;
    y2 = _y2;

    /* Définition de la sprite. */
    _sprite.aligner(GAUCHE, HAUT);
    sprite = _sprite;
  }

  /**
   * Affichage de la sprite.
   */
  void draw(float _x1, float _y1, float _x2, float _y2) {
    float x, y;
    float ox = sprite.x, oy = sprite.y;
    float sx = max(x1, _x1 - (_x1-x1) % sprite.largeur);
    float sy = max(y1, _y1 - (_y1-y1) % sprite.hauteur);
    float ex = min(x2, _x1 + 2 * _x2);
    float ey = min(y2, _y1 + 2 * _y2);

    for (x = sx; x < ex; x += sprite.largeur){
      for (y = sy; y < ey; y += sprite.hauteur){
        sprite.draw(x,y);
      }
    }
  }

  /**
   * Déterminer si l'objet est visible dans le cadre d'affichage actuel.
   */
  boolean affichable(float _x1, float _y1, float _x2, float _y2) {
    return true;
  } 
  
  /**
   * Affichage de l'objet.
   */
  void afficherObjet() {}
}
