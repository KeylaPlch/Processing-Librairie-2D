/**
 * Cette classe définit un chemin, le long duquel la
 * sprite sera déplacée.
 */
class SpriteChemin {
  /**
   * Liste de tous les points du chemin.
   */
  ArrayList<InformationTrame> info;

  /**
   * Décalage du chemin.
   */
  int decalageChemin;

  /**
   * Compteur de trames du chemin
   */
  int compteurTrames;

  /**
   * Le chemin est-il une boucle ?
   */
  boolean boucle;

  /**
   * La rotation est-elle désactivée ?
   */
  boolean desactiverRotation;

  /**
   * Classe privée pour l'information d'une trame.
   */
  private class InformationTrame {
    float x, y, ex, ey, rotation;

    InformationTrame(float _x, float _y, float _ex, float _ey, float _rotation) {
      x=_x; y=_y; ex=_ex; ey=_ey; rotation=_rotation; 
    }

    String deboguer() {
      return "Informations de trame : [" + x + ", " + y + ", " + ex + ", " + ey + ", " + rotation + "]"; 
    }
  }

  /**
   * Constructeur.
   */
  SpriteChemin() {
    info = new ArrayList<InformationTrame>();
  }

  /**
   * Récupérer les nombres de trames du chemin.
   */
  int size() {
    return info.size();
  }

  /**
   * Vérifier si le chemin est une boucle.
   */
  boolean verifierBoucle() {
    return boucle;
  }

  /**
   * Set this path to looping or terminating
   */
  void definirBoucle(boolean _boucle) {
    boucle = _boucle;
  }

  /**
   * Désactiver la rotation de la sprite.
   */
  void desactiverRotation(boolean _rotation) {
    desactiverRotation = _rotation;
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
  void ajouterPoint(float _x, float _y, float _ex, float _ey, float _rotation, int _duree) {
    InformationTrame trame = new InformationTrame(_x, _y, _ex, _ey, _rotation);
    
    /* Tant que la durée de cette trame est supérieur à 0. */
    while (_duree-- > 0) {
      /* Ajout de la trame au chemin. */
      info.add(trame);
    }
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
  void ajouterLigne(float _x1, float _y1, float _ex1, float _ey1, float _rotation1,
                    float _x2, float _y2, float _ex2, float _ey2, float _rotation2,
                    float _duree) {
    /* Temps restant. */
    float t;

    /* Temps écoulé. */
    float mt;

    /* Pour toutes les trames du chemin. */
    for (float i = 0; i <= _duree; i++) {
      t = i/_duree;
      mt = 1-t;
      ajouterPoint(mt * _x1 + t * _x2, mt * _y1 + t * _y2, mt * _ex1 + t * _ex2, mt * _ey1 + t * _ey2, (desactiverRotation ? _rotation1 : mt * _rotation1 + t * _rotation2), 1);
    }
  }

  /**
   * Définir le décalage du chemin.
   * @param _decalage Décalage du chemin.
   */
  void definirDecalage(int _decalage) {
    decalageChemin = _decalage;
  }

  /**
   * Réinitialiser le chemin.
   */
  void reinitialiser() {
    decalageChemin = 0;
    compteurTrames = 0;
  }

  /**
   * Récupérer les informations de la trame suivante.
   */
  float[] recupererInformationsTrameSuivante() {
    int trame = decalageChemin + compteurTrames++;
    if (trame < 0) { 
      trame = 0;
    } else if (!boucle && trame >= info.size()) {
      /* Dernière trame. */
      trame = info.size()-1; 
    } else {
      /* Boucle d'animation. */
      trame = trame % info.size();
    }

    InformationTrame pp = info.get(trame);
    return new float[] {pp.x, pp.y, pp.ex, pp.ey, pp.rotation};
  }

  /**
   * Affichage du chemin pour déboguage.
   */
  void draw() {
    /* S'il n'y a pas de trames dans le chemin. */
    if (info.size() == 0) return;

    ellipseMode(CENTER);
    InformationTrame actuel, precedent = info.get(0);

    /* Pour chaque point du chemin. */
    for (int i = 0; i < info.size(); i++) {
      actuel = info.get(i);
      
      /* Ligne du point précédent au point actuel. */
      line(precedent.x, precedent.y, actuel.x, actuel.y);

      /* Ellipse au point actuel. */
      ellipse(actuel.x, actuel.y, 5, 5);

      precedent = actuel;
    }
  }

  /**
   * Récupérer les informations de débogage.
   */ 
  String deboguer() {
    String chaine = "";
    /* Pour chaque point du chemin. */
    for (InformationTrame point : info) {
      /* Infomations de déboguage du point. */
      chaine += point.deboguer() + "\n";
    }
    return chaine;
  }
}
