/**
 * Traqueur.
 */
interface Traqueur {
  /**
   * Traquer un acteur.
   */
  void traquer(Acteur _acteur, float _x1, float _y1, float _x2, float _y2);
}

/**
 * Ce traqueur simple vérifie dans quelle direction 
 * nous devons bouger pour nous rapprocher de la proie.
 * Nous bougeons ensuite dans cette direction en
 * ajoutant de la vitesse.
 */
static class TraqueurSimple {

  /**
   * Traquer un objet positionnable.
   * @param _chasseur Objet traquant.
   * @param _proie Objet traqué.
   * @param _vitesse Vitesse de déplacement du chasseur.
   */
  static void traquer(Positionnable _chasseur, Positionnable _proie, float _vitesse) {
    float x1 = _proie.x;
    float y1 = _proie.y;
    float x2 = _chasseur.x;
    float y2 = _chasseur.y;

    /* Calcul de la direction de déplacement. */
    float angle = atan2(y2-y1, x2-x1);
    if(angle < 0) { angle += 2*PI; }
    
    /* Calcul de la vitesse à ajouter. */
    float vx = -cos(angle);
    float vy = -sin(angle);

    /* Ajout de la vitesse. */
    _chasseur.ajouterVitesse(_vitesse*vx, _vitesse*vy);
  }
}